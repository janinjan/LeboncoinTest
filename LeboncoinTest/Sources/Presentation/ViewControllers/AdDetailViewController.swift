//
//  AdDetailViewController.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

class AdDetailViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: AdDetailViewModel
    weak var coordinator: AdListCoordinator?

    // MARK: - UI Elements

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear

        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8

        return stackView
    }()

    lazy var adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .lbcGrey800
        label.numberOfLines = 0

        return label
    }()

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .lbcGrey600
        label.numberOfLines = 1

        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .lbcOrange
        label.numberOfLines = 1

        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lbcGrey700
        label.numberOfLines = 1

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .lbcGrey800
        label.numberOfLines = 1

        return label
    }()

    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        textView.textAlignment = .justified
        textView.textColor = .lbcGrey700
        textView.isEditable = false
        textView.isScrollEnabled = false

        return textView
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

    init(viewModel: AdDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle

    override func loadView() {
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lbcWhite
        displayAdInformations()
    }

    private func setupViews() {
        let view = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(urgentLabel)

        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 8).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        adImageView.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 600 : 300).isActive = true
        urgentLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -4).isActive = true
        urgentLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true

        stackView.addArrangedSubview(adImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionTextView)

        self.view = view
    }

    private func displayAdInformations() {
        let adDetail = viewModel.adDetail

        if let image = adDetail.imageThumbURL {
            adImageView.urlImage(image)
        }

        titleLabel.text = adDetail.title
        categoryLabel.text = adDetail.categoryName
        priceLabel.text = adDetail.price
        dateLabel.text = adDetail.creationDate
        descriptionLabel.text = viewModel.descriptionText
        descriptionTextView.text = adDetail.description
        urgentLabel.text = adDetail.isUrgent ? Strings.urgentAd : ""
        urgentLabel.isHidden = adDetail.isUrgent ? false : true
    }
}
