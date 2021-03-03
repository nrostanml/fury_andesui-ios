//
//  AndesAutocompleteTextField.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 03/03/2021.
//

import UIKit

public class AndesAutoCompleteTextField: AndesTextField {

//    private let tableViewContainer: UIView = {
//        let view = UIView()
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 5.0
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shadowRadius = 5.0
//        view.layer.shadowOpacity = 0.5
//        return view
//    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.isScrollEnabled = true
        tableView.indicatorStyle = .black
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.layer.masksToBounds = true
        return tableView
    }()

    class Suggestion {
        var title: String?
        var attributedTitle: NSMutableAttributedString?

        init(title: String) {
            self.title = title
        }
    }

    var dataList: [Suggestion] = [
        Suggestion(title: "Paris"),
        Suggestion(title: "Alemania"),
        Suggestion(title: "Portugal"),
        Suggestion(title: "Escocia"),
        Suggestion(title: "Pavard"),
        Suggestion(title: "Argentina")
    ]

    var resultsList: [Suggestion] = []

    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView.removeFromSuperview()
    }

    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
    }

    override func didEndEditing(text: String) {
        super.didEndEditing(text: text)
        tableView.isHidden = true
    }

    override func didChange() {
        super.didChange()
        filter()
        updateSearchTableView()
        tableView.isHidden = false
    }

    fileprivate func filter() {
        resultsList = []

        dataList
            .filter { ($0.title?.lowercased().contains(self.text.lowercased()))! }
            .forEach {
                let suggestionRange = ($0.title as NSString?)!.range(of: text, options: .caseInsensitive)

                if suggestionRange.location != NSNotFound {
                    $0.attributedTitle = NSMutableAttributedString(string: $0.title!)
                    $0.attributedTitle!.setAttributes([.font: AndesStyleSheetManager.styleSheet.lightSystemFont(size: 15.0)],
                                                        range: suggestionRange)

                    resultsList.append($0)
                }
            }

        tableView.reloadData()
    }
}

extension AndesAutoCompleteTextField: UITableViewDelegate, UITableViewDataSource {
    func buildSearchTableView() {
        tableView.delegate = self
        tableView.dataSource = self
//        tableViewContainer.addSubview(tableView)
//        window?.addSubview(tableViewContainer)
        window?.addSubview(tableView)
        updateSearchTableView()
    }

    // Updating SearchtableView
    func updateSearchTableView() {
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

//        var tableFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
//        tableFrame.origin = self.convert(tableViewFrame.origin, to: nil)

        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.tableView.frame = tableViewFrame
            //self?.tableViewContainer.frame = tableViewFrame
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

    // Adding rows in the tableview with the data from dataList
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clear

        let attributed: NSMutableAttributedString = resultsList[indexPath.row].attributedTitle!
        attributed.addAttribute(.font,
                                value: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 15.0),
                                range: NSRange(location: 0, length: attributed.string.count))

        cell.textLabel?.attributedText = attributed
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.text = resultsList[indexPath.row].title!
        tableView.isHidden = true
        endEditing(true)
    }
}
