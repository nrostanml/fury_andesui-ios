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
    public var title: String = ""
    public var text: String = ""
    public var detail: String = ""

    public init(title: String, text: String? = nil, detail: String) {
        self.title = title
        self.text = text ?? title
        self.detail = detail
    }
}

public class AndesAutoCompleteTextField: AndesTextField {

    // MARK: - Private Properties

    private let tableViewShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shouldRasterize = true
        view.layer.shadowColor = UIColor.black.cgColor
        return view
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        tableView.indicatorStyle = .black
        tableView.layer.masksToBounds = true
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = true
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

    weak var _delegate: AndesAutocompleteTextFieldDelegate?

    public override var delegate: AndesTextFieldDelegate? {
        didSet {
            if delegate is AndesAutocompleteTextFieldDelegate {
                super.delegate = delegate
                self._delegate = delegate as? AndesAutocompleteTextFieldDelegate
            }
        }
    }

    public var showBoldTitle: Bool = false

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
        executeForViews { $0.removeFromSuperview() }
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        buildTableView()
    }

    // MARK: - Overrided AndesTextField Methods

    override func didEndEditing(text: String) {
        super.didEndEditing(text: text)
        showViews()
    }

    override func didChange() {
        super.didChange()

        filter()
        updateTableView()
        hideViews()
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

    private func hideViews() {
        executeForViews { $0.isHidden = false }
    }

    private func showViews() {
        executeForViews { $0.isHidden = true }
    }

    private func executeForViews(completionBlock: (UIView) -> Void) {
        [tableViewShadow, tableView].forEach { completionBlock($0) }
    }
}

extension AndesAutoCompleteTextField: UITableViewDelegate, UITableViewDataSource {
    func buildTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        executeForViews {
            $0.layer.cornerRadius = 5
            window?.addSubview($0)
        }

        updateTableView()
    }

    func updateTableView() {
        executeForViews { superview?.bringSubviewToFront($0) }

        let tableHeight: CGFloat = tableView.contentSize.height < 150 ? tableView.contentSize.height : 150

        var tableViewFrame = CGRect(x: 0, y: -15, width: frame.size.width - 4, height: tableHeight)
        tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
        tableViewFrame.origin.x += 2
        tableViewFrame.origin.y += frame.size.height

        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.executeForViews { $0.frame = tableViewFrame }
            self?.layoutIfNeeded()
        }

        if isFirstResponder {
            superview?.bringSubviewToFront(self)
        }

        tableView.reloadData()
    }

    // MARK: TableViewDataSource Methods

    public func numberOfSections(in tableView: UITableView) -> Int { 1 }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { resultsList.count }

    // MARK: TableViewDelegate Methods

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AndesAutocompleteSuggestionCell.identifier,
                                                 for: indexPath) as! AndesAutocompleteSuggestionCell

        cell.titleLabel.text = resultsList[indexPath.row].title
        cell.detailLabel.text = resultsList[indexPath.row].detail

        cell.shouldBoldTitle(showBoldTitle)

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        text = suggestions[indexPath.row].text
        showViews()
        endEditing(true)
        _delegate?.suggestionSelected(suggestions[indexPath.row])
    }
}
