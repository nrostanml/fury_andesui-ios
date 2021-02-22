//
//  BottomSheetAppRouter.swift
//  AndesUI-demoapp
//
//  Created by Tomi De Lucca on 29/10/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

protocol BottomSheetRouter: NSObject {
    func route(from: UIViewController)
}

class BottomSheetAppRouter: NSObject {
    var view: AndesShowcasePageViewController!
}

extension BottomSheetAppRouter: BottomSheetRouter {
    func route(from: UIViewController) {
        view = AndesShowcasePageViewController(controllers: [BottomSheetSwiftExampleViewController(), BottomSheetObjectiveCExampleViewController()])
        view.title = "Bottom Sheet"
        from.navigationController?.pushViewController(view, animated: true)
    }
}
