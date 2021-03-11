//
//  AndesTooltipPosition.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 16-02-21.
//

import Foundation

@objc public enum AndesTooltipPosition: Int, AndesEnumStringConvertible {
    case top
    case bottom
    case left
    case right

    public static func keyFor(_ value: AndesTooltipPosition) -> String {
        switch value {
        case .top: return "top"
        case .bottom: return "bottom"
        case .left: return "left"
        case .right: return "right"
        }
    }
}
