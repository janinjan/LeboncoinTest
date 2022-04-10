//
//  FilterTableViewCell.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .lbcGrey800
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.reusableID)
        contentView.addSubview(titleLabel)
        setupLayoutConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configureCell(using model: CategoryModel) {
        titleLabel.text = model.name
    }

    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
