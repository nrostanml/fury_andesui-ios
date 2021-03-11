//
//  TooltipActionLightUseCase.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 10-02-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

class TooltipLightPrimaryCases: NSObject, TooltipActionUseCaseDataSource {

    func titleForType() -> String {
        return "Primary Action"
    }

    func supportTypes() -> [TooltipActionType] {
        return [.loud, .quiet, .link]
    }

}

@objc class TooltipLightSecondaryCases: NSObject, TooltipActionUseCaseDataSource {

    private let primaryAction: TooltipActionType

    init(primaryAction: TooltipActionType) {
        self.primaryAction = primaryAction
    }

    func titleForType() -> String {
        return "Secondary Action"
    }

    func supportTypes() -> [TooltipActionType] {
        switch primaryAction {
        case .loud:
            return [.transparent]
        case .link:
            return []
        case .quiet:
            return [.quiet]
        case .transparent:
            return []
        }
    }
}
