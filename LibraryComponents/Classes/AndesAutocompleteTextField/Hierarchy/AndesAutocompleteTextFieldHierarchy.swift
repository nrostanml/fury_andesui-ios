//
//  
//  AndesAutocompleteTextFieldHierarchy.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 17/03/2021.
//
//

import Foundation

/// Used to define the style of an AndesAutocompleteTextField
@objc public enum AndesAutocompleteTextFieldHierarchy: Int, AndesEnumStringConvertible {
    case loud
    case quiet

    public static func keyFor(_ value: AndesAutocompleteTextFieldHierarchy) -> String {
        switch value {
        case .loud: return "LOUD"
        case .quiet: return "QUIET"
        }
    }
}
