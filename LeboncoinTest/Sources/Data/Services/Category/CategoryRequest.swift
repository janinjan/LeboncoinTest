//
//  CategoryRequest.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

struct CategoryRequest: HTTPRequestProtocol {
    
    var path: String {
        "/leboncoin/paperclip/master/categories.json"
    }
    
    var method: HTTPMethod {
        .get
    }
}
