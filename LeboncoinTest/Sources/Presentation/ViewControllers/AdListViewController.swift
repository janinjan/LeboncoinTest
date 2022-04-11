//
//  AdListViewController.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit
import Combine

class AdListViewController: UIViewController {

    // MARK: - Property wrappers

    @Published private var isResetEnabled: Bool = false

    // MARK: - Properties

    private let viewModel: AdListViewModel
    weak var coordinator: AdListCoordinator?

    // MARK: - Subscribers

    private var resetSubscriber: AnyCancellable?

    // MARK: - UI Elements

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AdListTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    private var filterBarButtonItem = UIBarButtonItem()
    private var resetBarButtonItem = UIBarButtonItem()

    // MARK: - Initializer

    init(viewModel: AdListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadAds()
        setupTableView()
        bindData()
    }

    // MARK: - Methods

    private func setupUI() {
        title = viewModel.title
        view.backgroundColor = .lbcWhite
        setupBarButtonItem()
    }

    private func setupBarButtonItem() {
        filterBarButtonItem = UIBarButtonItem(
            title: viewModel.filterButtonText,
            style: .plain,
            target: self,
            action: #selector(didTapFilterButtonItem))

        resetBarButtonItem = UIBarButtonItem(
            title: viewModel.resetButtonText,
            style: .plain,
            target: self,
            action: #selector(didTapResetButtonItem))

        navigationItem.leftBarButtonItem = resetBarButtonItem
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem = filterBarButtonItem
    }

    @objc func didTapFilterButtonItem() {
        coordinator?.didTapFilterButtonItem()
    }

    @objc func didTapResetButtonItem() {
        viewModel.resetFilter()
        title = viewModel.title
        tableView.reloadData()
    }

    private func setupTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadAds() {
        Task { @MainActor in
            await viewModel.getAds()
            self.tableView.reloadData()
        }
    }

    private func bindData() {
        coordinator?.updateCategory = { category in
            self.viewModel.refresh(category: category) {
                self.tableView.reloadData()
                self.title = self.viewModel.title
                self.toggleResetBarButton()
            }
        }
    }

    private func toggleResetBarButton() {
        resetSubscriber = viewModel.resetPublisher
            .sink { [weak self] value in
                self?.navigationItem.leftBarButtonItem?.isEnabled = value
            }
    }
}

// MARK: - extension UITableViewDatasource

extension AdListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfTableViewItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdListTableViewCell.reusableID,
                                                       for: indexPath) as? AdListTableViewCell else {
            return UITableViewCell()
        }

        let ads = viewModel.getCellInfo(at: indexPath.row)
        cell.configureCell(using: ads)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear

        return cell
    }
}

// MARK: - extension UITableViewDelegate

extension AdListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let adDetail = viewModel.getCellInfo(at: indexPath.row)
        coordinator?.didTapCell(adDetail)
    }
}
