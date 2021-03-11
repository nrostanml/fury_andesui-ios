//
//  AndesTooltipTypeHighlight.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 08-02-21.
//

import Foundation

struct AndesTooltipTypeHighlight: AndesTooltipTypeProtocol {
    let textColor = UIColor.Andes.white
    let backgroundColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor
    let maxWidth: CGFloat = 260
    let shadowOffset: CGSize = CGSize(width: 0, height: 0)
    let shadowRadius: CGFloat = 6
    let shadowOpacity: CGFloat = 0.3
    let closeButtonColor: UIColor = UIColor.Andes.white
    let shadowColor: UIColor = UIColor.Andes.graySolid800
}
