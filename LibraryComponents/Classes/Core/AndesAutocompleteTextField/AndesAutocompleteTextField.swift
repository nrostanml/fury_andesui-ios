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
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(AutocompleteSuggestionCell.self, forCellReuseIdentifier: AutocompleteSuggestionCell.identifier)
        tableView.isScrollEnabled = true
        tableView.indicatorStyle = .black
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.layer.masksToBounds = true
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    public var suggestions: [Suggestion] = [] {
        didSet {
            updateTableView()
        }
    }

    private var resultsList: [Suggestion] = []

    public weak var myDelegate: AndesAutocompleteTextFieldDelegate? {
        didSet {
            super.delegate = myDelegate
        }
    }
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView.removeFromSuperview()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        buildTableView()
    }

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

    fileprivate func filter() {
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
        var tableHeight: CGFloat = 0
        tableHeight = tableView.contentSize.height < 150 ? tableView.contentSize.height : 150

        // Set a bottom margin
        if tableHeight < tableView.contentSize.height {
            tableHeight -= 10
        }

        // Set tableView frame
        
        var tableViewFrame = CGRect(x: 0, y: -20, width: frame.size.width - 4, height: tableHeight)
        tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
        tableViewFrame.origin.x += 2
        tableViewFrame.origin.y += frame.size.height

        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.tableView.frame = tableViewFrame
        })
        
        if self.isFirstResponder {
            superview?.bringSubviewToFront(self)
        }

        tableView.reloadData()
    }

    // MARK: TableViewDataSource methods
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }

    // MARK: TableViewDelegate methods

    // Adding rows in the tableview with the data from suggestions
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AutocompleteSuggestionCell.identifier,
                                                 for: indexPath) as! AutocompleteSuggestionCell
        
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
