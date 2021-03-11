//
//  TooltipRouter.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 22-01-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import UIKit

class TooltipRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let controller = AndesShowcasePageViewController(
            controllers: [
                TooltipViewController(),
                TooltipObjcViewController()
            ])
        from.navigationController?.pushViewController(controller, animated: true)
    }
}
