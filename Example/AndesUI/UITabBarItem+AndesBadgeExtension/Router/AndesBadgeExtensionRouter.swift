//
//  AndesBadgeExtensionRoutern.swift
//  AndesUI-demoapp
//
//  Created by Julián Lima on 03/02/2021.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

protocol AndesBadgeExtensionRouter: NSObject {
    func route(from: UIViewController)
}

class AndesBadgeExtensionAppRouter: NSObject {
    var view: AndesBadgeExtensionTabBarController!
}

extension AndesBadgeExtensionAppRouter: AndesBadgeExtensionRouter {
    func route(from: UIViewController) {
        view = AndesBadgeExtensionTabBarController()
        from.navigationController?.pushViewController(view, animated: true)
    }
}
