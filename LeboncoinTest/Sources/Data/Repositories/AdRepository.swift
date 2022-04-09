//
//  AdRepository.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

final class AdRepository {

    // MARK: - Properties

    private let adService: AdsServiceProtocol
    private let categoryService: CategoryServiceProtocol
    private var categories: [Int: CategoryData] = [:]

    // MARK: - Initializer

    init(adService: AdsServiceProtocol,
         categoryService: CategoryServiceProtocol) {
        self.adService = adService
        self.categoryService = categoryService
    }

    // MARK: - Methods

    private func convertCategoriesToDict(categories: Categories) -> [Int: CategoryData] {
        let categoriesDict = categories.reduce([Int: CategoryData]()) { (partialResult, category) -> [Int: CategoryData] in
            var result = partialResult
            result[category.id] = category

            return result
        }

        return categoriesDict
    }
}

// MARK: - Enum AdRepositoryError

enum AdRepositoryError: Error {
    case unableToFetchAds
}

// MARK: - extension AdRepositoryProtocol

extension AdRepository: AdRepositoryProtocol {
    func retrieveAds() async throws -> [AdDomain] {
        do {
            async let categories = categoryService.fetchCategories()
            async let ads = adService.fetchAds()

            let (fetchedCategories, fetchedAds) = try await (categories, ads)

            self.categories = convertCategoriesToDict(categories: fetchedCategories)

            return fetchedAds.map({$0.mapToDomain(categories: self.categories)})
        } catch {
            throw AdRepositoryError.unableToFetchAds
        }
    }
}
