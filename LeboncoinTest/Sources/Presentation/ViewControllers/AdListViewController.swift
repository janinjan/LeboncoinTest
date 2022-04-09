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
    private var dataSource: TableViewDataSource<AdModel, AdListTableViewCell>?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AdListTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()

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
            adsDidLoad(viewModel.ads)

            self.tableView.reloadData()
        }
    }

    private func adsDidLoad(_ ads: [AdModel]) {
        dataSource = TableViewDataSource(models: ads,
                                         reuseIdentifier: AdListTableViewCell.reusableID) { adModel, cell in
            cell.configureCell(using: adModel)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
        }

        tableView.dataSource = dataSource
    }
}
