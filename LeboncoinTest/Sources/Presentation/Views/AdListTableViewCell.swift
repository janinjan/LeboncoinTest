//
//  AdListTableViewCell.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

class AdListTableViewCell: UITableViewCell {

    // MARK: - UI Element
    
    lazy var adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true

        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .lbcGrey800
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lbcGrey600
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lbcOrange
        label.textAlignment = .left
        label.numberOfLines = 1

        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [adImageView, titleLabel, categoryLabel, priceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 2

        return stackView
    }()

    lazy var urgentLabel: UILabel = {
        let label = PaddingLabel(top: 4, left: 8, bottom: 4, right: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .lbcPaleOrange
        label.numberOfLines = 1
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true

        return label
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.reusableID)
        setupViews()
        setupLayoutConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configureCell(using model: AdModel) {
        titleLabel.text = model.title
        categoryLabel.text = model.categoryName
        priceLabel.text = model.price
        urgentLabel.text = model.isUrgent ? Strings.urgentAd : ""
        urgentLabel.isHidden = model.isUrgent ? false : true

        if let image = model.imageThumbURL {
            adImageView.urlImage(image)
        }
    }

    private func setupViews() {
        contentView.addSubview(stackView)
        contentView.addSubview(urgentLabel)
    }

    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            adImageView.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 300 : 155),
            urgentLabel.trailingAnchor.constraint(equalTo: adImageView.trailingAnchor, constant: -6),
            urgentLabel.topAnchor.constraint(equalTo: adImageView.topAnchor, constant: 6)
        ])
    }
}
