//
//  
//  AndesAutocompleteTextFieldAbstractView.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 17/03/2021.
//
//

import UIKit

class AndesAutocompleteTextFieldAbstractView: UIView, AndesAutocompleteTextFieldView {
    @IBOutlet weak var componentView: UIView!

    var config: AndesAutocompleteTextFieldViewConfig
    init(withConfig config: AndesAutocompleteTextFieldViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesAutocompleteTextFieldViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesAutocompleteTextFieldViewConfig) {
        self.config = config
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        componentView.pinToSuperview()
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()
    }

    /// Override this method on each Badge View to setup its unique components
    func updateView() {
        self.backgroundColor = config.backgroundColor
    }
}
