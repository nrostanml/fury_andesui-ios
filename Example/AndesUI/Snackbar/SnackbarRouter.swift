//
//  SnackbarROuter.swift
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 6/16/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

protocol SnackbarRouter: NSObject {
    func route(from: UIViewController)
}

class SnackbarAppRouter: NSObject {
    var view: AndesShowcasePageViewController!
}

extension SnackbarAppRouter: SnackbarRouter {
    func route(from: UIViewController) {
        view = AndesShowcasePageViewController(controllers: [SnackbarViewController(), SnackbarObjCViewController()])
        view.title = "AndesSnackbar"
        from.navigationController?.pushViewController(view, animated: true)
    }
}
