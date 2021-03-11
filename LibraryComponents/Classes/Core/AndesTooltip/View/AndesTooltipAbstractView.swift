//
//  
//  AndesTooltipAbstractView.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import UIKit

class AndesTooltipAbstractView: UIView, AndesTooltipView {

    @IBOutlet private weak var componentView: UIView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var closeButtonHeightConstraint: NSLayoutConstraint!

    private(set) var config: AndesTooltipViewConfig
    weak var delegate: AndesTooltipViewDelegate?

    lazy var tooltip: AndesBaseTooltipView = {
        let tooltip = AndesBaseTooltipView(content: componentView, config: config)
        tooltip.delegate = self
        return tooltip
    }()

    init(withConfig config: AndesTooltipViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesTooltipViewConfig) {
        self.config = config
        updateView()
    }

    func show(in view: UIView, within superView: UIView, position: AndesTooltipPosition) {
        tooltip.show(target: view, withinSuperview: superView, position: position)
    }

    @objc func dismiss() {
        self.tooltip.dismiss()
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()
    }

    func updateView() {
        contentLabel.text = config.content
        contentLabel.accessibilityLabel = config.content
        contentLabel.setAndesStyle(style: config.getContentStyle())
        renderTitleIfNeeded()
        renderCloseButtonIfNeeded()
    }

    private func renderTitleIfNeeded() {
        guard let title = config.title else {
            titleLabel.removeFromSuperview()
            return
        }

        titleLabel.text = title
        titleLabel.accessibilityLabel = config.title
        titleLabel.setAndesStyle(style: config.getTitleStyle())
    }

    private func renderCloseButtonIfNeeded() {
        if !config.isDismissable {
            hideCloseButton()
            return

        }
        let closeIcon = AndesIcons.close16
        AndesIconsProvider.loadIcon(name: closeIcon) { image in
            self.closeButton.setImage(image, for: .normal)
            self.closeButton.tintColor = config.closeButtonColor
        }
    }

    private func hideCloseButton() {
        self.closeButtonHeightConstraint.constant = 0
    }

    func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        componentView.pinToSuperview()
    }

    @IBAction func closeButtonTapped() {
        self.dismiss()
    }
}

extension AndesTooltipAbstractView: AndesBaseTooltipViewDelegate {
    func onDismissed() {
        self.delegate?.onDismissed()
    }
}
