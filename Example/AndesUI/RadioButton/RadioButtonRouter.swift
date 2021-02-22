//
//  RadioButtonRouter.swift
//  AndesUI-demoapp
//
//  Created by Rodrigo Pintos Costa on 6/30/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

protocol RadioButtonRouter: NSObject {
    func route(from: UIViewController)
}

class RadioButtonAppRouter: NSObject {
    var view: AndesShowcasePageViewController!
}

extension RadioButtonAppRouter: RadioButtonRouter {
    func route(from: UIViewController) {
        view = AndesShowcasePageViewController(controllers: [AndesRadioButtonViewController(), RadioButtonObjCViewController()])
        view.title = "Andes RadioButton"
        from.navigationController?.pushViewController(view, animated: true)
    }
}
