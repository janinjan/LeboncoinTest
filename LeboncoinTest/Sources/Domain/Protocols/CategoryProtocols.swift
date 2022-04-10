//
//  CategoryProtocols.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import Foundation

protocol CategoryUsecaseProtocol {
    func retrieveCategories() async -> [CategoryDomain]
}

protocol CategoryRepositoryProtocol {
    func retrieveCategories() async throws -> [CategoryDomain]
}
