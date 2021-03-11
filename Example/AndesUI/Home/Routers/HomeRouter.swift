//
//  HomeRouter.swift
//  AndesUI_Example
//
//  Created by Santiago Lazzari on 19/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol {
    func route(from: UIViewController)
}

enum TestappViews {
    case progressIndicator
    case coachmark
    case buttons
    case messages
    case badges
    case whatsNew
    case textField
    case checkBox
    case radioButton
    case tag
    case snackbar
    case card
    case thumbnail
    case textFieldsCode
    case datePicker
    case bottomSheet
    case list
    case dropdown
    case andesBadgeExtensions
    case tooltip
}

protocol HomeRouter: class {
    func start(in window: UIWindow)
    func doRoute (fromVC: UIViewController, newRouter: TestappViews)
}

class HomeAppRouter: HomeRouter {
    func start(in window: UIWindow) {
        let viewController = HomeViewController()
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }

    func doRoute (fromVC: UIViewController, newRouter: TestappViews) {
        var router: HomeRouterProtocol
        switch newRouter {
        case .progressIndicator:
            router = AndesBadgeExtensionRouter()
        case .coachmark:
            router = CoachmarkRouter()
        case .buttons:
            router = ButtonsRouter()
        case .messages:
            router = MessagesRouter()
        case .badges:
            router = BadgesRouter()
        case .whatsNew:
            router = WhatsNewRouter()
        case .textField:
            router = TextFieldsRouter()
        case .checkBox:
            router = CheckboxRouter()
        case .radioButton:
            router = RadioButtonRouter()
        case .tag:
            router = TagsRouter()
        case .snackbar:
            router = SnackbarRouter()
        case .card:
            router = CardRouter()
        case .thumbnail:
            router = ThumbnailRouter()
        case .textFieldsCode:
            router = TextFieldsCodeRouter()
        case .datePicker:
            router = DatePickerRouter()
        case .bottomSheet:
            router = BottomSheetRouter()
        case .list:
            router = ListRouter()
        case .dropdown:
            router = DropdownRouter()
        case .andesBadgeExtensions:
            router = AndesBadgeExtensionRouter()
        case .tooltip:
            router = TooltipRouter()
        }
        router.route(from: fromVC)
    }
}
