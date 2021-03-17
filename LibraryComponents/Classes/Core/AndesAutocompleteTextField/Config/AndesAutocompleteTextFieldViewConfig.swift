//
//  
//  AndesAutocompleteTextFieldViewConfig.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 17/03/2021.
//
//

import Foundation

/// used to define the ui of internal AndesAutocompleteTextField views
internal struct AndesAutocompleteTextFieldViewConfig {
    var backgroundColor: UIColor?
    var textColor: UIColor?
    init() {}

    init(type: AndesAutocompleteTextFieldTypeProtocol, hierarchy: AndesAutocompleteTextFieldHierarchyProtocol) {
        self.textColor = type.textColor
        self.backgroundColor = hierarchy.backgroundColor
    }
}
