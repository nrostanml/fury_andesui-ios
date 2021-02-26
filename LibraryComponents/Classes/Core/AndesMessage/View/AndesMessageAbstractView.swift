//
//  AndesMessageView.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 1/14/20.
//

import UIKit

class AndesMessageAbstractView: UIView, AndesMessageView, UITextViewDelegate, AndesBulletViewDelegate {
    weak var delegate: AndesMessageViewDelegate?

    @IBOutlet var messageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconContainerView: UIView!
    @IBOutlet weak var leftPipeView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleToDismissConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleToSafeAreaConstraint: NSLayoutConstraint!
    @IBOutlet weak var bulletStackView: UIStackView!
    @IBOutlet weak var bulletStackTopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var bulletStackHeightConstraint: NSLayoutConstraint?

    var config: AndesMessageViewConfig
    init(withConfig config: AndesMessageViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesMessageViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesMessageViewConfig) {
        self.config = config
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: messageView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: messageView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: messageView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: messageView.bottomAnchor).isActive = true
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()

        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        messageView.clipsToBounds = true
    }

    @IBAction func dismissPressed(_ sender: Any) {
        self.delegate?.dismissTapped()
    }

    /// Override this method on each Message View to setup its unique components
    func updateView() {
        self.backgroundColor = config.backgroundColor
        self.leftPipeView.backgroundColor = config.pipeColor

        self.bodyTextView.setAndesStyle(style: config.bodyStyle)
        self.bodyTextView.attributedText = getBodyText(style: config.bodyStyle)
        self.bodyTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: config.bodyLinkTextColor]
        self.bodyTextView.delegate = self

        self.iconView.tintColor = config.iconColor
        if let icon = config.icon {
            AndesIconsProvider.loadIcon(name: icon, placeItInto: self.iconView)
        }
        self.iconContainerView.backgroundColor = config.iconBackgroundColor

        self.titleLabel.text = config.titleText

        if config.titleText == nil || config.titleText!.isEmpty {
            titleLabel.isHidden = true
        } else {
            self.titleLabel.setAndesStyle(style: config.titleStyle)
            self.titleLabel.text = config.titleText
            self.titleLabel.isHidden = false
        }

        if config.isDismissable, let iconName = config.dismissIconName {
            self.dismissButton.isHidden = false
            self.titleToDismissConstraint.priority = .init(rawValue: 999)
            self.titleToSafeAreaConstraint.priority = .defaultLow
            self.dismissButton.tintColor = config.dismissIconColor
            AndesIconsProvider.loadIcon(name: iconName) {
                self.dismissButton.setImage($0, for: .normal)
            }
            self.dismissButton.accessibilityLabel = "Cerrar".localized()
        } else {
            self.titleToDismissConstraint.priority = .defaultLow
            self.titleToSafeAreaConstraint.priority = .init(rawValue: 999)
            self.dismissButton.isHidden = true
        }

        self.bulletsSetup()
    }

    func bulletsSetup() {

        self.adjustBulletStackSpaces()

        self.removeAllBullets()

        for (index, bullet) in self.config.bullets.enumerated() {
            let bulletView = AndesBulletView(frame: .zero)
            let bodyStyle = config.bodyStyle
            let bulletText = self.getAttributedText(text: bullet.text, style: bodyStyle, bodyLinks: bullet.bodyLinks)
            bulletView.configure(bulletColor: bodyStyle.textColor, bulletText: bulletText, delegate: self, at: index)
            self.bulletStackView.addArrangedSubview(bulletView)
        }
    }

    func adjustBulletStackSpaces() {
        let hasBullets = !self.config.bullets.isEmpty
        let bodyEmpty = self.config.bodyText?.isEmpty ?? true

        if hasBullets == false {
            return
        }

        self.bulletStackHeightConstraint?.isActive = false
        self.bulletStackHeightConstraint = nil

        if hasBullets && bodyEmpty {
            self.bulletStackTopSpaceConstraint.constant = 4.0
        }

        if hasBullets && !bodyEmpty {
            self.bulletStackTopSpaceConstraint.constant = 8.0
        }
    }

    func removeAllBullets() {
        let views = self.bulletStackView.arrangedSubviews
        for view in  views {
            self.bulletStackView.removeArrangedSubview(view)
        }
    }

    func getBodyText(style: AndesFontStyle) -> NSAttributedString {
        let body = config.bodyText ?? ""
        return getAttributedText(text: body, style: style, bodyLinks: config.bodyLinks)
    }

    func getAttributedText(text: String, style: AndesFontStyle, bodyLinks: AndesBodyLinks?) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)

        let allRange = NSRange(location: 0, length: attributedString.length)

        attributedString.addAttribute(.foregroundColor, value: style.textColor, range: allRange)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = style.lineSpacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: allRange)

        if let bodyLinks = bodyLinks {
            for (index, link) in bodyLinks.links.enumerated() {
                if link.isValidRange(attributedString) {
                    let range = NSRange(location: link.startIndex, length: link.endIndex - link.startIndex)
                    attributedString.addAttribute(.link, value: String(describing: index), range: range)

                    if config.bodyLinkIsUnderline {
                        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
                    }
                }
            }
        }

        return attributedString
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let index = Int(String(describing: URL)) ?? 0
        config.bodyLinks?.listener(index)
        return false
    }

    func andesbulletView(urlInteractionAt linkIndex: Int, forBullet bulletIndex: Int) {
        config.bullets[bulletIndex].bodyLinks.listener(linkIndex)
    }
}
