//
//  
//  AndesAutocompleteTextFieldType.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 17/03/2021.
//
//

import Foundation

/// Used to define the colors of an AndesAutocompleteTextField
@objc public enum AndesAutocompleteTextFieldType: Int, AndesEnumStringConvertible {
    case success
    case error

    public static func keyFor(_ value: AndesAutocompleteTextFieldType) -> String {
        switch value {
        case .success: return "SUCCESS"
        case .error: return "ERROR"
        }
    }
}
