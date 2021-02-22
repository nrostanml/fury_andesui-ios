//
//  WhatsNewRouter.swift
//  AndesUI-demoapp
//
//  Created by Nicolas Rostan Talasimov on 2/6/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

protocol WhatsNewRouter: NSObject {
    func route(from: UIViewController)
}

class WhatsNewAppRouter: NSObject {
    var view: WhatsNewViewController!
}

extension WhatsNewAppRouter: ButtonsRouter {
    func route(from: UIViewController) {
        view = WhatsNewViewController()
        from.navigationController?.pushViewController(view, animated: true)
    }
}
