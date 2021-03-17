//
//  
//  AndesAutocompleteTextFieldViewConfigFactory.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 17/03/2021.
//
//

import Foundation

internal class AndesAutocompleteTextFieldViewConfigFactory {
    static func provideInternalConfig(type: AndesAutocompleteTextFieldType, hierarchy: AndesAutocompleteTextFieldHierarchy) -> AndesAutocompleteTextFieldViewConfig {
        let typeIns = AndesAutocompleteTextFieldTypeFactory.provide(type)
        let hierarchyIns = AndesAutocompleteTextFieldHierarchyFactory.provide(hierarchy)

        let config = AndesAutocompleteTextFieldViewConfig(type: typeIns, hierarchy: hierarchyIns)

        return config
    }
}
