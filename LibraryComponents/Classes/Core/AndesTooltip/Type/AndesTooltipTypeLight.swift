//
//  
//  AndesTooltipTypeLight.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

struct AndesTooltipTypeLight: AndesTooltipTypeProtocol {
    let textColor: UIColor = UIColor.Andes.graySolid800
    let backgroundColor: UIColor = UIColor.Andes.white
    let maxWidth: CGFloat = 260
    let shadowOffset: CGSize = CGSize(width: 0, height: 0)
    let shadowRadius: CGFloat = 6
    let shadowOpacity: CGFloat = 0.3
    let closeButtonColor: UIColor = UIColor.Andes.graySolid800
    let shadowColor: UIColor = UIColor.Andes.graySolid800
}
