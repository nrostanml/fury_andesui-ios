//
//  CardRouter.swift
//  AndesUI-demoapp
//
//  Created by Martin Victory on 14/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

protocol CardRouter: NSObject {
    func route(from: UIViewController)
}

class CardAppRouter: NSObject {
    var view: AndesShowcasePageViewController!
}

extension CardAppRouter: CardRouter {
    func route(from: UIViewController) {
        view = AndesShowcasePageViewController(controllers: [CardViewController(), CardObjCViewController()])
        view.title = "AndesCard"
        from.navigationController?.pushViewController(view, animated: true)
    }
}
