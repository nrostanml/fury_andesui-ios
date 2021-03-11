//
//  AndesTooltipHighlightLoudHierarchy.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 12-02-21.
//

import Foundation

struct AndesTooltipHighlightLoudHierarchy: AndesButtonHierarchyProtocol {
    let idleColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor600
    let pressedColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor300
    let focusColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor200
    let disableColor: UIColor = UIColor.Andes.gray100
    let fontColor: UIColor = AndesStyleSheetManager.styleSheet.textColorWhite
    let spinnerTintColor: UIColor = .clear
}
