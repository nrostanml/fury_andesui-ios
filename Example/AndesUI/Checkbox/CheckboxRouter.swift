//
//  CheckboxRouter.swift
//  AndesUI-demoapp
//
//  Created by Rodrigo Pintos Costa on 6/12/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

protocol CheckboxRouter: NSObject {
    func route(from: UIViewController)
}

class CheckboxAppRouter: NSObject {
    var view: AndesCheckboxShowcaseViewController!
}

extension CheckboxAppRouter: CheckboxRouter {
    func route(from: UIViewController) {
        view = AndesCheckboxShowcaseViewController()
        from.navigationController?.pushViewController(view, animated: true)
    }
}
