//
//  
//  AndesAutocompleteTextFieldFactory.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 17/03/2021.
//
//

import Foundation

internal class AndesAutocompleteTextFieldHierarchyFactory {
    static func provide(_ hierarchy: AndesAutocompleteTextFieldHierarchy) -> AndesAutocompleteTextFieldHierarchyProtocol {
        switch hierarchy {
        case .loud:
            return AndesAutocompleteTextFieldHierarchyLoud()
        case .quiet:
            return AndesAutocompleteTextFieldHierarchyQuiet()
        }
    }
}
