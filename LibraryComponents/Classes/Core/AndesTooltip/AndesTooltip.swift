//
//  
//  AndesTooltip.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

@objc public class AndesTooltip: UIView {
    internal var contentView: AndesTooltipView!

    let type: AndesTooltipType
    let title: String?
    let content: String
    let isDismissable: Bool

    let primaryAction: AndesTooltipAction?
    let secondaryAction: AndesTooltipAction?

    /// Block that is executed when the tooltip disappears.
   @objc public var dismissHandler: (() -> Void)?

    /// show the tooltip in the view
    /// - Parameters:
    ///   - view: view to which you want to highlight
    ///   - superView: view to which the tooltip is added
    ///   - position: preferred position for the tooltip
    @objc public func show(in view: UIView, within superView: UIView, position: AndesTooltipPosition = .top) {
        self.contentView.show(in: view, within: superView, position: position)
    }

    /// dismiss the tooltip
    @objc public func dismiss() {
        self.contentView.dismiss()
    }

    /// Constructor for tooltip
    /// - Parameters:
    ///   - type: type of tooltip
    ///   - content: String representing content of tooltip
    ///   - title: String representing title of tooltip
    ///   - isDismissable: Boolean representing if the tooltip has a close button
    ///   - primaryLoudAction: Action with style Loud
    @objc public convenience init(
        type: AndesTooltipType,
        content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryLoudAction: AndesTooltipAction? = nil
    ) {
        primaryLoudAction?.configure(with: .loud)
        self.init(content: content, title: title, isDismissable: isDismissable, type: type, primaryAction: primaryLoudAction)
    }

    /// Constructor for tooltip
    /// - Parameters:
    ///   - type: type of tooltip
    ///   - content: String representing content of tooltip
    ///   - title: String representing title of tooltip
    ///   - isDismissable: Boolean representing if the tooltip has a close button
    ///   - linkAction: Action with style link
    @objc public convenience init(
        type: AndesTooltipType,
        content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        linkAction: AndesTooltipAction
    ) {
        linkAction.configure(with: .link)
        self.init(content: content, title: title, isDismissable: isDismissable, type: type, primaryAction: linkAction)
    }

    /// Constructor for tooltip
    /// - Parameters:
    ///   - type: type of tooltip
    ///   - content: String representing content of tooltip
    ///   - title: String representing title of tooltip
    ///   - isDismissable: Boolean representing if the tooltip has a close button
    ///   - primaryLoudAction: Action with style loud
    ///   - secondaryTransparentAction: Action with style transparent
    @objc public convenience init(
        type: AndesTooltipType,
        content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryLoudAction: AndesTooltipAction,
        secondaryTransparentAction: AndesTooltipAction

    ) {
        primaryLoudAction.configure(with: .loud)
        secondaryTransparentAction.configure(with: .transparent)
        self.init(content: content, title: title, isDismissable: isDismissable, type: type, primaryAction: primaryLoudAction, secondaryAction: secondaryTransparentAction)
    }

    /// Constructor for special light tooltip
    /// - Parameters:
    ///   - content: String representing content of tooltip
    ///   - title: String representing title of tooltip
    ///   - isDismissable: Boolean representing if the tooltip has a close button
    ///   - primaryQuietAction: Action with style quiet
    ///   - secondaryQuietAction: Action with style quiet
    @objc public convenience init(
        lightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryQuietAction: AndesTooltipAction,
        secondaryQuietAction: AndesTooltipAction

    ) {
        primaryQuietAction.configure(with: .quiet)
        secondaryQuietAction.configure(with: .quiet)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .light, primaryAction: primaryQuietAction, secondaryAction: secondaryQuietAction)
    }

    /// Constructor for special light tooltip
    /// - Parameters:
    ///   - content: String representing content of tooltip
    ///   - title: String representing title of tooltip
    ///   - isDismissable: Boolean representing if the tooltip has a close button
    ///   - primaryQuietAction: Action with style quiet
    @objc public convenience init(
        lightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryQuietAction: AndesTooltipAction
    ) {
        primaryQuietAction.configure(with: .quiet)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .light, primaryAction: primaryQuietAction)
    }

    private init(
        content: String,
        title: String?,
        isDismissable: Bool,
        type: AndesTooltipType,
        primaryAction: AndesTooltipAction? = nil,
        secondaryAction: AndesTooltipAction? = nil) {

        self.content = content
        self.title = title
        self.isDismissable = isDismissable
        self.type = type
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func drawContentView(with newView: AndesTooltipView) {
        self.contentView = newView
        self.contentView.delegate = self
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesTooltipView {
        let config = AndesTooltipViewConfigFactory.provideInternalConfig(tooltip: self)

        let withActions = primaryAction != nil || secondaryAction != nil

        if withActions {
            return AndesTooltipViewActions(withConfig: config)
        }

        return AndesTooltipViewDefault(withConfig: config)
    }
}

extension AndesTooltip: AndesTooltipViewDelegate {
    func onDismissed() {
        dismissHandler?()
    }
}
