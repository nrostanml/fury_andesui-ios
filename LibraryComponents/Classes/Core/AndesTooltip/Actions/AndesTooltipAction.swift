//
//  AndesTooltipAction.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 10-02-21.
//

import Foundation

@objc public class AndesTooltipAction: NSObject {
    let text: String
    let onPressed: (() -> Void)
    var type: AndesTooltipActionType = .loud

    @objc public init(text: String, onPressed: @escaping (() -> Void)) {
        self.text = text
        self.onPressed = onPressed
    }

    func configure(with type: AndesTooltipActionType) {
        self.type = type
    }
}

internal enum AndesTooltipActionType {
    case loud
    case quiet
    case link
    case transparent
}

internal class AndesTooltipActionFactory {

    class func provide(action: AndesTooltipAction, tooltipType: AndesTooltipType) -> AndesButtonViewConfig {

        switch action.type {
        case .link:
            return createLinkConfig(action: action, tooltipType: tooltipType)
        case .loud:
            return createLoudConfig(action: action, tooltipType: tooltipType)
        case .quiet:
            return createQuietConfig(action: action)
        case .transparent:
            return createTransparentConfig(action: action, tooltipType: tooltipType)
        }
    }

    private class func createLoudConfig(action: AndesTooltipAction, tooltipType: AndesTooltipType) -> AndesButtonViewConfig {
        switch tooltipType {
        case .light, .dark:
            return AndesButtonViewConfigFactory.provide(hierarchy: .loud, size: .medium, text: action.text, icon: nil)
        case .highlight:
            let hierarchy = AndesTooltipHighlightLoudHierarchy()
            return AndesButtonViewConfigFactory.provide(
                hierarchy: hierarchy,
                size: AndesButtonSizeMedium(),
                text: action.text,
                textattributes: [:],
                icon: nil)
        }
    }

    private class func createTransparentConfig(action: AndesTooltipAction, tooltipType: AndesTooltipType) -> AndesButtonViewConfig {
        switch tooltipType {
        case .light:
            return AndesButtonViewConfigFactory.provide(hierarchy: .transparent, size: .medium, text: action.text, icon: nil)
        case .highlight, .dark:
            let hierarchy = AndesTooltipActionBasicHierarchy(textColor: UIColor.Andes.white, pressedColor: .clear)
            return AndesButtonViewConfigFactory.provide(
                hierarchy: hierarchy,
                size: AndesButtonSizeMedium(),
                text: action.text,
                textattributes: [:],
                icon: nil)
        }
    }

    private class func createQuietConfig(action: AndesTooltipAction) -> AndesButtonViewConfig {
            return AndesButtonViewConfigFactory.provide(hierarchy: .quiet, size: .medium, text: action.text, icon: nil)
    }

    private class func createLinkConfig(action: AndesTooltipAction, tooltipType: AndesTooltipType) -> AndesButtonViewConfig {

        let textAttr = provideLinkAttr(tooltipType: tooltipType)
        let hierarchy = provideActionLinkHierarchy(tooltipType: tooltipType)
        return AndesButtonViewConfigFactory.provide(
            hierarchy: hierarchy,
            size: AndesLinkButtonSizeMedium(),
            text: action.text,
            textattributes: textAttr,
            icon: nil)
    }

    private class func provideLinkAttr(tooltipType: AndesTooltipType) ->  [NSAttributedString.Key: Any] {
        switch tooltipType {
        case .dark, .highlight:
            return [.underlineStyle: NSUnderlineStyle.single.rawValue]
        case .light:
            return [:]
        }
    }

    private class func provideActionLinkHierarchy(tooltipType: AndesTooltipType) -> AndesButtonHierarchyProtocol {
        switch tooltipType {
        case .dark, .highlight:
            return AndesTooltipActionBasicHierarchy(textColor: UIColor.Andes.white, pressedColor: .clear)
        case .light:
            return AndesTooltipActionBasicHierarchy(textColor: AndesStyleSheetManager.styleSheet.accentColor, pressedColor: .clear)
        }
    }

}
