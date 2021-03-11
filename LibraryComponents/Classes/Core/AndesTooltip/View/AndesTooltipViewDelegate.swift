//
//  AndesTooltipViewDelegate.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 03-03-21.
//

import Foundation

/**
 /// Used to route events form internal message views to AndesTooltip
 */
internal protocol AndesTooltipViewDelegate: UIView {
    func onDismissed()
}
