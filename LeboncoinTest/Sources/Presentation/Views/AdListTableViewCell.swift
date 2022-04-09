//
//  AdListTableViewCell.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

class AdListTableViewCell: UITableViewCell {

    // MARK: - UI Element

    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .lbcBlack
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.reusableID)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    
    func configureCell(using model: AdModel) {
        title.text = model.title
    }

    private func setupViews() {
        contentView.addSubview(title)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
