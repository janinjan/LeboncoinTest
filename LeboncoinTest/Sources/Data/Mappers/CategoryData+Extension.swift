//
//  CategoryData+Extension.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import Foundation

extension CategoryData {

    var toDomain: CategoryDomain {
        CategoryDomain(id: id, name: name)
    }
}
