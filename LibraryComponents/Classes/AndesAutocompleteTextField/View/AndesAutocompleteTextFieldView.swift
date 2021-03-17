//
//  
//  AndesAutocompleteTextFieldView.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 17/03/2021.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesAutocompleteTextField
 */
internal protocol AndesAutocompleteTextFieldView: UIView {
    func update(withConfig config: AndesAutocompleteTextFieldViewConfig)
}
