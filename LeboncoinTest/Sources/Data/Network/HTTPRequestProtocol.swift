//
//  HTTPRequestProtocol.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

protocol HTTPRequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: String? { get }
}

// MARK: - extension HTTPRequestProtocol

extension HTTPRequestProtocol {

    var headers: [String: String]? {
        nil
    }

    var body: String? {
        nil
    }
}
