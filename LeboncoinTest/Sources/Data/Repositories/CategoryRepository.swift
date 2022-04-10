//
//  CategoryRepository.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import Foundation

final class CategoryRepository {

    // MARK: - Properties

    private let categoryService: CategoryServiceProtocol

    // MARK: - Initializer

    init(categoryService: CategoryServiceProtocol) {
        self.categoryService = categoryService
    }
}

// MARK: - Enum CategoryRepositoryError

enum CategoryRepositoryError: Error {
    case unableToFetchCategories
}

// MARK: - extension AdRepositoryProtocol

extension CategoryRepository: CategoryRepositoryProtocol {
    func retrieveCategories() async throws -> [CategoryDomain] {
        do {
            let fetchedCategories = try await categoryService.fetchCategories()

            return fetchedCategories.map({$0.toDomain})
        } catch {
            throw CategoryRepositoryError.unableToFetchCategories
        }
    }
}
