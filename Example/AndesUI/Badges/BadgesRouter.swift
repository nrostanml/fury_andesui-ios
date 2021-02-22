//
//  BadgesRouter.swift
//  AndesUI-demoapp
//

import UIKit

protocol BadgesRouter: NSObject {
    func route(from: UIViewController)
}

class BadgesAppRouter: NSObject {
    var view: AndesBadgeShowcaseViewController!
}

extension BadgesAppRouter: BadgesRouter {
    func route(from: UIViewController) {
        view = AndesBadgeShowcaseViewController()
        from.navigationController?.pushViewController(view, animated: true)
    }
}
