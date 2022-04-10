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

    // MARK: - UI Elements

    private var confirmButtonItem = UIBarButtonItem()

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
        coordinator?.dismissViewController()
    }
}
