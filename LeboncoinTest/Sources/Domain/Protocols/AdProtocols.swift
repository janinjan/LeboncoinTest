//
//  AdProtocols.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

protocol AdRepositoryProtocol {
    func retrieveAds() async throws -> [AdDomain]
}
