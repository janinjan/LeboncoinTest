//
//  CategoryUsecase.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import Foundation
import os

final class CategoryUsecase {

    // MARK: - Properties

    let repository: CategoryRepositoryProtocol

    // MARK: - Initializer

    init(repository: CategoryRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - extension AdUsecaseProtocol {

extension CategoryUsecase: CategoryUsecaseProtocol {

    func retrieveCategories() async -> [CategoryDomain] {
        do {
            let categories = try await repository.retrieveCategories()

            return categories
        } catch {
            os_log("Retrieving categories error", log: Logger.networking, type: .default)
        }

        return []
    }
}
