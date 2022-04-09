//
//  CategoryService.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

final class CategoryService {

    // MARK: - Properties

    private let networkClient: NetworkClient
    private static let scheme = "https"
    private static let host = "raw.githubusercontent.com"

    private let categoryRequest = CategoryRequest()

    // MARK: - Initializer

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    // MARK: - Methods

    func fetchCategories() async throws -> Categories {
        try await networkClient.getServiceResponse(request: categoryRequest,
                                                   scheme: CategoryService.scheme,
                                                   host: CategoryService.host)
    }
}
