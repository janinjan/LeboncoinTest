//
//  AdDomain+Extension.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

extension AdDomain {

    var toUI: AdModel {
        AdModel(categoryName: categoryName,
                title: title,
                description: description,
                price: "\(price.cleanValue) €",
                imageSmallURL: imageSmallURL,
                imageThumbURL: imageThumbURL,
                creationDate: DateFormatter.shortDateFormatter.string(from: creationDate),
                isUrgent: isUrgent)
    }
}
