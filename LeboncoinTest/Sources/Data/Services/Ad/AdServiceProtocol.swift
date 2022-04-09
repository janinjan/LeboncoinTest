//
//  AdServiceProtocol.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

protocol AdsServiceProtocol {
    func fetchAds() async throws -> Ads
}
