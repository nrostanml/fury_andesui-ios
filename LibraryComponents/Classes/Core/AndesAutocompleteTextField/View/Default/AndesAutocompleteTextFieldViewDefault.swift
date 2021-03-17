//
//  
//  AndesAutocompleteTextFieldViewDefault.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 17/03/2021.
//
//

import Foundation

class AndesAutocompleteTextFieldViewDefault: AndesAutocompleteTextFieldAbstractView {
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesAutocompleteTextFieldViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
