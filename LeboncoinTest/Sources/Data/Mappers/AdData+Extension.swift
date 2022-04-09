//
//  AdData+Extension.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

extension AdData {

    func mapToDomain(categories: [Int: CategoryData]) -> AdDomain {
        AdDomain(id: id,
                 categoryName: getCategoryName(categories: categories),
                 title: title,
                 description: description,
                 price: price,
                 imageSmallURL: imagesURL.small,
                 imageThumbURL: imagesURL.thumb,
                 creationDate: creationDate.toDate,
                 isUrgent: isUrgent)
    }

    private func getCategoryName(categories: [Int: CategoryData]) -> String {
        return categories[categoryID]?.name ?? ""
    }
}
