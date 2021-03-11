//
//  HomeViewController.swift
//  AndesUI_Example
//
//  Created by Santiago Lazzari on 19/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import UIKit

import AndesUI

protocol HomeView: NSObject {

}

class HomeViewController: UIViewController {

    private let presenter: HomePresenter

    @IBOutlet weak var progressIndicatorBtn: AndesButton!
    @IBOutlet weak var coachmarkBtn: AndesButton!
    @IBOutlet weak var button: AndesButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var messagesBtn: AndesButton!
    @IBOutlet weak var badgesBtn: AndesButton!
    @IBOutlet weak var welcomeMessage: AndesMessage!
    @IBOutlet weak var radioButton: AndesButton!
    @IBOutlet weak var textFieldBtn: AndesButton!
    @IBOutlet weak var checkboxBtn: AndesButton!
    @IBOutlet weak var tagBtn: AndesButton!
    @IBOutlet weak var snackbarBtn: AndesButton!
    @IBOutlet weak var cardBtn: AndesButton!
    @IBOutlet weak var specsButton: AndesButton!
    @IBOutlet weak var contributingButton: AndesButton!
    @IBOutlet weak var thumbnailBtn: AndesButton!
    @IBOutlet weak var showcaseLabel: UILabel!

    init() {
        self.presenter = HomePresenter()
        super.init(nibName: nil, bundle: nil)
        self.presenter.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            showcaseLabel.text = "\("home.label.showcase".localized) (v\(version))"
        }

        setupUI()
    }

    private func setupUI() {
        func setupNavigation() {
            navigationItem.title = "AndesUI"
        }

        func setupMessage() {
            welcomeMessage.title = "home.welcomeMsg.title".localized
            welcomeMessage.body = "home.welcomeMsg.desc".localized
            welcomeMessage.setPrimaryAction("home.welcomeMsg.action".localized, handler: { _ in
                self.presenter.present(view: .whatsNew)
            })
        }

        func setupButtons() {
            specsButton.text = "Andes Specs 📘"
            contributingButton.text = "home.button.contribute.title".localized
        }

        setupButtons()
        setupNavigation()
        setupMessage()
    }

    @IBAction func goToCoachmarkWasTapped(_ sender: Any) {
        presenter.present(view: .coachmark)
    }

    @IBAction func goToButtonWasTapped(_ sender: Any) {
        presenter.present(view: .buttons)
    }

    @IBAction func goToMessagesTapped(_ sender: Any) {
        presenter.present(view: .messages)
    }

    @IBAction func goToBadgesTapped(_ sender: Any) {
        presenter.present(view: .badges)
    }

    @IBAction func goToCheckboxTapped(_ sender: Any) {
        presenter.present(view: .checkBox)
    }

    @IBAction func goToRadioButtonTapped(_ sender: Any) {
        presenter.present(view: .radioButton)
    }

    @IBAction func goToDatePickerTapped(_ sender: Any) {
        presenter.present(view: .datePicker)
    }

    @IBAction func goToSpecsTapped(_ sender: Any) {
        guard let url = URL(string: "https://company-161429.frontify.com/d/kxHCRixezmfK/n-a") else { return }
        UIApplication.shared.open(url)
    }

    @IBAction func goToContributingTapped(_ sender: Any) {
        guard let url = URL(string: "https://meli.workplace.com/notes/andes-ui/c%C3%B3mo-contribuir-en-andes-ui/2559399620854933") else { return }
        UIApplication.shared.open(url)
    }

    @IBAction func progressIndicatorBtnTapped(_ sender: Any) {
        presenter.present(view: .progressIndicator)
    }

    @IBAction func textfieldBtnTapped(_ sender: Any) {
        presenter.present(view: .textField)
    }

    @IBAction func tagBtnTapped(_ sender: Any) {
        presenter.present(view: .tag)
    }

    @IBAction func snackbarBtnTapped(_ sender: Any) {
        presenter.present(view: .snackbar)
    }

    @IBAction func cardBtnTapped(_ sender: Any) {
        presenter.present(view: .card)
    }

    @IBAction func goToThumbnailTapped(_ sender: Any) {
        presenter.present(view: .thumbnail)
    }

    @IBAction func goToListViewTapped(_ sender: Any) {
        presenter.present(view: .list)
    }

    @IBAction func goToTextFieldsCodeTapped(_ sender: Any) {
        presenter.present(view: .textFieldsCode)
    }

    @IBAction func bottomSheetTapped(_ sender: Any) {
        presenter.present(view: .bottomSheet)
    }

    @IBAction func dropdownTapped(_ sender: Any) {
        presenter.present(view: .dropdown)
    }

    @IBAction func andesBadgeExtensionTapped(_ sender: Any) {
        presenter.present(view: .badges)
    }

    @IBAction func tooltipTapped(_ sender: Any) {
        presenter.present(view: .tooltip)
    }
}
