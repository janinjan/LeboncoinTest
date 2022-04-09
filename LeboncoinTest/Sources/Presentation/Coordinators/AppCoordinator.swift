//
//  AppCoordinator.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    let navigationController: UINavigationController
    private let window: UIWindow
    lazy var childCoordinators: [Coordinator] = []

    // MARK: - Initializer

    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    // MARK: - Methods

    func start() {
        let adListCoordinator = AdListCoordinator(navigationController: navigationController, parentCoordinator: self)
        childCoordinators.append(adListCoordinator)
        adListCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func childDidFinish(_ child: Coordinator) {
        removeChild(child)
    }
}
