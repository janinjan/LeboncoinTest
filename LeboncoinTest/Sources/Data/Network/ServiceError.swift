//
//  ServiceError.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

enum ServiceError: Error {
    case unableToCreateRequest
    case unableToDecodeJSON
    case badResponse
}
