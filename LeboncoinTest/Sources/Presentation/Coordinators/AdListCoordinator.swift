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
    var updateCategory: ((CategoryModel) -> Void)?

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

    func startDetail(with adDetail: AdModel) {
        let viewModel = AdDetailViewModel(adDetail: adDetail)
        let adDetailViewController = AdDetailViewController(viewModel: viewModel)
        adDetailViewController.coordinator = self

        navigationController.pushViewController(adDetailViewController, animated: true)
    }

    func startFilter() {
        let filterCoordinator = FilterCoordinator(navController: navigationController, parentCoordinator: self)
        childCoordinators.append(filterCoordinator)
        filterCoordinator.delegate = self
        filterCoordinator.start()
    }

    func didTapCell(_ adDetail: AdModel) {
        startDetail(with: adDetail)
    }

    func didTapFilterButtonItem() {
        startFilter()
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

    func childDidFinish(_ child: Coordinator) {
        removeChild(child)
    }
}

// MARK: - extension CategorySelectionDelegate

extension AdListCoordinator: CategorySelectionDelegate {
    func selectedFilter(filter: CategoryModel) {
        updateCategory?(filter)
    }
}
