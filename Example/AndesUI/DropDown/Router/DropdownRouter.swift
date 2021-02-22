//
//  DropdownRouter.swift
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

protocol DropdownRouter: NSObject {
    func route(from: UIViewController)
}

class DropdownAppRouter: NSObject {
    var view: AndesShowcasePageViewController!
}

extension DropdownAppRouter: DropdownRouter {
    func route(from: UIViewController) {
        view = AndesShowcasePageViewController(controllers: [DropdownViewController(), DropDownObjcViewController()])
        view.title = "AndesDropdown"
        from.navigationController?.pushViewController(view, animated: true)
    }
}
