//
//  ListRouter.swift
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 16/10/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

protocol ListRouter: NSObject {
    func route(from: UIViewController)
}

class ListAppRouter: NSObject {
    var view: AndesShowcasePageViewController!
}

extension ListAppRouter: ListRouter {
    func route(from: UIViewController) {
        view = AndesShowcasePageViewController(controllers: [ListViewController(),
                                                             ListObjcViewController()])
        view.title = "AndesList"
        from.navigationController?.pushViewController(view, animated: true)
    }
}
