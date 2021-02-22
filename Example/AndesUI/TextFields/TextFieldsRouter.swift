//
//  TextFieldsRouter.swift
//  AndesUI-demoapp
//
//  Created by Martin Damico on 13/03/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

protocol TextFieldsRouter: NSObject {
    func route(from: UIViewController)
}

class TextFieldsAppRouter: NSObject {
    var view: AndesShowcasePageViewController!
}

extension TextFieldsAppRouter: TextFieldsRouter {
    func route(from: UIViewController) {
        view = AndesShowcasePageViewController(controllers: [TextFieldViewController(), TextAreaViewController(), TextFieldObjCViewController()])
        view.title = "AndesTextField"
        from.navigationController?.pushViewController(view, animated: true)
    }
}
