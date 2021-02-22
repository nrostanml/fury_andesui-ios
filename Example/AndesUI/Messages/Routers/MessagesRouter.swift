//
//  MessagesRouter.swift
//  AndesUI_Example
//
//  Created by Nicolas Rostan Talasimov on 1/16/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

protocol MessagesRouter: NSObject {
    func route(from: UIViewController)
}

class MessagesAppRouter: NSObject {
    var view: AndesShowcasePageViewController!
}

extension MessagesAppRouter: MessagesRouter {
    func route(from: UIViewController) {
        view = AndesShowcasePageViewController(controllers: [MessageViewController(), MessageObjCViewController()])
        view.title = "AndesMessage"
        from.navigationController?.pushViewController(view, animated: true)
    }
}
