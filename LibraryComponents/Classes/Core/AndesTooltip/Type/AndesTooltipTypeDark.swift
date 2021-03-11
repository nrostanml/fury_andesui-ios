//
//  AndesTooltipTypeDark.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 08-02-21.
//

import Foundation

struct AndesTooltipTypeDark: AndesTooltipTypeProtocol {
    let textColor: UIColor = UIColor.Andes.white
    let backgroundColor: UIColor = UIColor.Andes.graySolid800
    let maxWidth: CGFloat = 260
    let shadowOffset: CGSize = CGSize(width: 0, height: 0)
    let shadowRadius: CGFloat = 6
    let shadowOpacity: CGFloat = 0.3
    let closeButtonColor: UIColor = UIColor.Andes.white
    var shadowColor: UIColor = UIColor.Andes.graySolid800
}
