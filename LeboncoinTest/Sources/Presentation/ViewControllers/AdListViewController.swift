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
        title = viewModel.title
        view.backgroundColor = .white

        Task { @MainActor in
            await viewModel.getAds()
            print(viewModel.ads)
        }
    }
}
