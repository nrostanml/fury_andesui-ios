//
//  DatePickerRouter.swift
//  AndesUI-demoapp
//
//  Created by Ândriu Felipe Coelho on 14/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

protocol DatePickerRouter: NSObject {
    func route(from: UIViewController)
}

class DatePickerAppRouter: NSObject {
    var view: DatePickerViewController!
}

extension DatePickerAppRouter: DatePickerRouter {
    func route(from: UIViewController) {
        view = DatePickerViewController()
        from.navigationController?.pushViewController(view, animated: true)
    }
}
