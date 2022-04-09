//
//  AdService.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

final class AdService {
    
    // MARK: - Properties
    
    private static let scheme = "https"
    private static let host = "raw.githubusercontent.com"
    
    private let networkClient: NetworkClient
    private let adRequest = AdRequest()
    
    // MARK: - Initializer
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - extension AdsServiceProtocol

extension AdService: AdsServiceProtocol {
    func fetchAds() async throws -> Ads {
        try await networkClient.getServiceResponse(request: adRequest,
                                                   scheme: AdService.scheme,
                                                   host: AdService.host)
    }
}
