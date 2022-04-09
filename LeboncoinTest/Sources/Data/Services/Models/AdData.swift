//
//  AdData.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

// MARK: - Ads

typealias Ads = [AdData]

// MARK: - AdData

struct AdData: Codable {
    let id: Int
    let categoryID: Int
    let title: String
    let description: String
    let price: Float
    let imagesURL: AdDataImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case description
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}
