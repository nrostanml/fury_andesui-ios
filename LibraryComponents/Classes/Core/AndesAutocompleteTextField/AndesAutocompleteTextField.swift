//
//  AndesAutocompleteTextField.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 03/03/2021.
//

import UIKit

public protocol AndesAutocompleteTextFieldDelegate: AndesTextFieldDelegate {
    func suggestionSelected(_ suggestion: Suggestion)
}

public class Suggestion {
    var title: String = ""
    var detail: String = ""

    public init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
}

public class AndesAutoCompleteTextField: AndesTextField {

    // MARK: - Private Properties

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.isScrollEnabled = true
        tableView.indicatorStyle = .black
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.layer.masksToBounds = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AndesAutocompleteSuggestionCell.self,
                           forCellReuseIdentifier: AndesAutocompleteSuggestionCell.identifier)
        return tableView
    }()

    private var resultsList: [Suggestion] = []

    // MARK: - Public Properties

    public var suggestions: [Suggestion] = [] {
        didSet {
            updateTableView()
        }
    }

    public weak var myDelegate: AndesAutocompleteTextFieldDelegate? {
        didSet {
            super.delegate = myDelegate
        }
    }

    // MARK: - Initializers

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrided UIView Methods

    override open func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView.removeFromSuperview()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        buildTableView()
    }

    // MARK: - Overrided AndesTextField Methods

    override func didEndEditing(text: String) {
        super.didEndEditing(text: text)
        tableView.isHidden = true
    }

    override func didChange() {
        super.didChange()

        filter()
        updateTableView()
        tableView.isHidden = false
    }

    // MARK: - Private Methods

    private func filter() {
        resultsList = []

        suggestions
            .filter { ($0.title.lowercased().contains(text.lowercased())) }
            .forEach {
                let suggestionRange = ($0.title as NSString).range(of: text, options: .caseInsensitive)

                if suggestionRange.location == NSNotFound { return }

                resultsList.append($0)
            }

        tableView.reloadData()
    }
}

extension AndesAutoCompleteTextField: UITableViewDelegate, UITableViewDataSource {
    func buildTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        window?.addSubview(tableView)
        updateTableView()
    }

    func updateTableView() {
        superview?.bringSubviewToFront(tableView)

        // Set tableView frame

        let tableHeight: CGFloat = tableView.contentSize.height < 150 ? tableView.contentSize.height : 150

        var tableViewFrame = CGRect(x: 0, y: -20, width: frame.size.width - 4, height: tableHeight)
        tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
        tableViewFrame.origin.x += 2
        tableViewFrame.origin.y += frame.size.height

        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.tableView.frame = tableViewFrame
        }

        if isFirstResponder {
            superview?.bringSubviewToFront(self)
        }

        tableView.reloadData()
    }

    // MARK: TableViewDataSource methods

    public func numberOfSections(in tableView: UITableView) -> Int { 1 }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { resultsList.count }

    // MARK: TableViewDelegate methods

    // Adding rows in the tableview with the data from suggestions
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AndesAutocompleteSuggestionCell.identifier,
                                                 for: indexPath) as! AndesAutocompleteSuggestionCell

        cell.titleLabel.text = resultsList[indexPath.row].title
        cell.detailLabel.text = resultsList[indexPath.row].detail

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.text = suggestions[indexPath.row].title
        tableView.isHidden = true
        endEditing(true)
        myDelegate?.suggestionSelected(suggestions[indexPath.row])
    }
}
