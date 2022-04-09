//
//  AdListViewController.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

class AdListViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: AdListViewModel
    weak var coordinator: AdListCoordinator?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AdListTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self

        return tableView
    }()

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
    }

    // MARK: - Methods

    private func setupUI() {
        title = viewModel.title
        view.backgroundColor = .lbcWhite
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
}

// MARK: - Extension UITableViewDataSource

extension AdListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTableViewItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdListTableViewCell.reusableID) as? AdListTableViewCell else {
            return UITableViewCell()
        }

        cell.configureCell(using: viewModel.getAdInfo(for: indexPath.row))

        return cell
    }
}
