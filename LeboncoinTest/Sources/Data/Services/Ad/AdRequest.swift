//
//  AdRequest.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

struct AdRequest: HTTPRequestProtocol {
    
    var path: String {
        "/leboncoin/paperclip/master/listing.json"
    }
    
    var method: HTTPMethod {
        .get
    }
}
