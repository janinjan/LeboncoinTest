//
//  FilterViewController.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import UIKit

class FilterViewController: UIViewController {
    
    // MARK: - Properties

    private let viewModel: FilterViewModel
    weak var coordinator: FilterCoordinator?
    private var dataSource: TableViewDataSource<CategoryModel, FilterTableViewCell>?
    private var selectedCategory: CategoryModel?

    // MARK: - UI Elements

    private var confirmButtonItem = UIBarButtonItem()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilterTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.delegate = self

        return tableView
    }()

    // MARK: - Initializer
    
    init(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Deinit

    deinit {
        coordinator?.childFinished()
    }

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadCategories()
    }

    // MARK: - Methods

    private func setupUI() {
        title = viewModel.title
        view.backgroundColor = .lbcWhite
        setupBarButtonItem()
    }

    private func setupBarButtonItem() {
        confirmButtonItem = UIBarButtonItem(
            title: viewModel.confirmButtonText,
            style: .plain,
            target: self,
            action: #selector(didTapConfirmButtonItem))

        navigationItem.rightBarButtonItem = confirmButtonItem
    }

    @objc func didTapConfirmButtonItem() {
        if let category = selectedCategory {
            coordinator?.selectedFilter(filter: category)
        }

        coordinator?.dismissViewController()
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

    private func loadCategories() {
        Task { @MainActor in
            await viewModel.getCategories()
            categoriesDidLoad(viewModel.categories)

            self.tableView.reloadData()
        }
    }

    private func categoriesDidLoad(_ categories: [CategoryModel]) {
        dataSource = TableViewDataSource(models: categories,
                                         reuseIdentifier: FilterTableViewCell.reusableID) { category, cell in
            cell.configureCell(using: category)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.tintColor = .lbcOrange
        }

        tableView.dataSource = dataSource
    }
}

// MARK: - extension UITableViewDelegate

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let currentCategory = viewModel.didTapCategoryCell(at: indexPath.row)
        selectedCategory = currentCategory
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
