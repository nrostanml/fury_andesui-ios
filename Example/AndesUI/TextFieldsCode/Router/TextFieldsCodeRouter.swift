//
//  TextFieldsCodeRouter.swift
//  AndesUI-demoapp
//
//  Created by Esteban Adrian Boffa on 16/09/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

protocol TextFieldsCodeRouter: NSObject {
    func route(from: UIViewController)
}

final class TextFieldsCodeAppRouter: NSObject {
    var view: AndesShowcasePageViewController?
}

extension TextFieldsCodeAppRouter: TextFieldsCodeRouter {
    func route(from: UIViewController) {
        view = AndesShowcasePageViewController(controllers: [TextFieldsCodeViewController(), TextFieldsCodeObjCViewController()])
        if let view = view {
            from.navigationController?.pushViewController(view, animated: true)
        }
    }
}
