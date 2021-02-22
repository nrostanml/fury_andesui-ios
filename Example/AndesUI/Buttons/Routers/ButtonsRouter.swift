//
//  ButtonsRouter.swift
//  AndesUI_Example
//
//  Created by Santiago Lazzari on 19/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import UIKit

protocol ButtonsRouter: NSObject {
    func route(from: UIViewController)
}

class ButtonsAppRouter: NSObject {
    var view: ButtonsViewController!
}

extension ButtonsAppRouter: ButtonsRouter {
    func route(from: UIViewController) {
        view = ButtonsViewController()
        from.navigationController?.pushViewController(view, animated: true)
    }
}
