//
//  CategoryData.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

// MARK: - Categories

typealias Categories = [CategoryData]

// MARK: - Category

struct CategoryData: Codable {
    let id: Int
    let name: String
}
