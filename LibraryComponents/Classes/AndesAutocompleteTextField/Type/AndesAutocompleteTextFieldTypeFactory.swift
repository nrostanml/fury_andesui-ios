//
//  
//  AndesAutocompleteTextFieldTypeFactory.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 17/03/2021.
//
//

import Foundation

class AndesAutocompleteTextFieldTypeFactory {
    static func provide(_ type: AndesAutocompleteTextFieldType) -> AndesAutocompleteTextFieldTypeProtocol {
        switch type {
        case .success:
            return AndesAutocompleteTextFieldTypeSuccess()
        case .error:
            return AndesAutocompleteTextFieldTypeError()
        }
    }
}
