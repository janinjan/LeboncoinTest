//
//  AdModel.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

struct AdModel: Equatable {
    var categoryName: String
    let title: String
    let description: String
    let price: String
    let imageSmallURL: String?
    let imageThumbURL: String?
    let creationDate: String
    let isUrgent: Bool
}
