//
//  CategoryDomain+Extension.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import Foundation

extension CategoryDomain {

    var toCategoryModel: CategoryModel {
        CategoryModel(id: id, name: name)
    }
}
