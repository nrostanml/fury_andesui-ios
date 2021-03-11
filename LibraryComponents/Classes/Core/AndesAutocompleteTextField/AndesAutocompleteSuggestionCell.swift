//
//  AndesAutocompleteSuggestionCell.swift
//  AndesUI
//
//  Created by Ariel Goldfryd on 09/03/2021.
//

import UIKit

class AndesAutocompleteSuggestionCell: UITableViewCell {

    // MARK: - UI Properties

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: FontSize.title)
        return label
    }()

    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AndesStyleSheetManager.styleSheet.lightSystemFont(size: FontSize.detail)
        return label
    }()

    // MARK: - Public Properties

    public static let identifier = String(describing: AndesAutocompleteSuggestionCell.self)

    // MARK: - Private Properties

    private enum FontSize {
        static let title: CGFloat = 15.0
        static let detail: CGFloat = 15.0
    }

    private enum Margin {
        static let vertical: CGFloat = 12.0
        static let horizontal: CGFloat = 8.0
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margin.vertical),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.horizontal),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.horizontal),

            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.vertical),
            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.horizontal),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.horizontal),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margin.vertical)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public func shouldBoldTitle(_ shouldBe: Bool) {
        let font = shouldBe
            ? AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: FontSize.title)
            : AndesStyleSheetManager.styleSheet.regularSystemFont(size: FontSize.title)

        titleLabel.font = font
    }
}
