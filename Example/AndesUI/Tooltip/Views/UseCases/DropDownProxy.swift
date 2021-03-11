//
//  DropDownProxy.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 18-02-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

protocol DropdownProxyDelegate: class {
    func didSelect(_ dropdownProxy: DropdownProxy, rowAt indexPath: IndexPath)
}

class DropdownProxy: AndesDropdownDelegate {

    weak var delegate: DropdownProxyDelegate?

    func didSelectRowAt(indexPath: IndexPath) {
        self.delegate?.didSelect(self, rowAt: indexPath)
    }
}
