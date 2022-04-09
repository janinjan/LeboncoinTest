//
//  CoordinatorProtocol.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

// MARK: - extension Coordinator {

extension Coordinator {

    func removeChild(_ child: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return child === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
