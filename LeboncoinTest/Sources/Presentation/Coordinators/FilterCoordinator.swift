//
//  FilterCoordinator.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import UIKit

protocol CategorySelectionDelegate: AnyObject {
    func selectedFilter(filter: CategoryModel)
}

final class FilterCoordinator: Coordinator {

    // MARK: - Properties

    let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    lazy var childCoordinators: [Coordinator] = []
    weak var delegate: CategorySelectionDelegate?

    // MARK: - Initializer

    init(navController: UINavigationController, parentCoordinator: Coordinator) {
        self.navigationController = navController
        self.parentCoordinator = parentCoordinator
    }

    // MARK: - Methods

    func start() {
        let filterViewController = FilterViewController(viewModel: setupFilterViewModelDependencies())
        filterViewController.coordinator = self

        let navigationCustom = UINavigationController(rootViewController: filterViewController)
        navigationController.present(navigationCustom, animated: true, completion: nil)
    }

    func selectedFilter(filter: CategoryModel) {
        delegate?.selectedFilter(filter: filter)
    }

    func dismissViewController() {
        navigationController.dismiss(animated: true, completion: nil)
    }

    func childDidFinish(_ child: Coordinator) {
        removeChild(child)
    }

    /**
     Remove child from parent's coordinator
     */
    func childFinished() {
        parentCoordinator?.childDidFinish(self)
    }

    private func setupFilterViewModelDependencies() -> FilterViewModel {
        let networkClient = NetworkClient()
        let service = CategoryService(networkClient: networkClient)
        let repository = CategoryRepository(categoryService: service)
        let usecase = CategoryUsecase(repository: repository)

        return FilterViewModel(categoryUsecase: usecase)
    }
}
