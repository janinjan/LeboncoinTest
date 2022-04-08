//
//  NetworkClientProtocol.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

protocol NetworkClientProtocol {
    func getServiceResponse<T: Codable>(request: HTTPRequestProtocol,
                                        scheme: String,
                                        host: String) async throws -> (T)
}
