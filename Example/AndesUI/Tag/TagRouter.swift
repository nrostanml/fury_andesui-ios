//
//  TagRouter.swift
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 5/29/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

protocol TagsRouter: NSObject {
    func route(from: UIViewController)
}

class TagsAppRouter: NSObject {
    var view: AndesTagShowcaseViewController!
}

extension TagsAppRouter: TagsRouter {
    func route(from: UIViewController) {
        view = AndesTagShowcaseViewController()
        from.navigationController?.pushViewController(view, animated: true)
    }
}
