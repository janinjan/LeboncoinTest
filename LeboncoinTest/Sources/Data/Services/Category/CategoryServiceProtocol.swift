//
//  CategoryServiceProtocol.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

protocol CategoryServiceProtocol {
    func fetchCategories() async throws -> Categories
}
