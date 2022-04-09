//
//  AdListCoordinator.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

final class AdListCoordinator: Coordinator {

    // MARK: - Properties

    let navigationController: UINavigationController
    let parentCoordinator: Coordinator?
    lazy var childCoordinators: [Coordinator] = []

    // MARK: - Initializer

    init(navigationController: UINavigationController, parentCoordinator: Coordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }

    // MARK: - Methods

    func start() {
        let adListViewController = AdListViewController(viewModel: setupAdListViewModelDependencies())
        adListViewController.coordinator = self

        configureNavigation()

        navigationController.setViewControllers([adListViewController], animated: false)
    }

    private func setupAdListViewModelDependencies() -> AdListViewModel {
        let networkClient = NetworkClient()
        let adService = AdService(networkClient: networkClient)
        let categoryService = CategoryService(networkClient: networkClient)
        let adRepository = AdRepository(adService: adService, categoryService: categoryService)
        let usecase = AdUsecase(repository: adRepository)

        return AdListViewModel(adUsecase: usecase)
    }

    private func configureNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lbcBlack]
        appearance.shadowColor = .clear

        let navigationBar = navigationController.navigationBar
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
