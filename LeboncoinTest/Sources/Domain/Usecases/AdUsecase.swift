//
//  AdUsecase.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation
import os

final class AdUsecase {

    // MARK: - Properties

    let repository: AdRepositoryProtocol

    // MARK: - Initializer

    init(repository: AdRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - extension AdUsecaseProtocol {

extension AdUsecase: AdUsecaseProtocol {

    func retrieveAds() async -> [AdDomain] {
        do {
            let ads = try await repository.retrieveAds()

            return sortAds(ads)
        } catch {
            os_log("Retrieving ads error", log: Logger.networking, type: .default)
        }

        return []
    }

    /**
     This method sorts the ads array according to business rules
     * Ads are sorted by date
     * Ads marked as urgent are at the top of the array
     */
    func sortAds(_ ads: [AdDomain]) -> [AdDomain] {
        let sortedAds = ads.sorted { (lhs, rhs) in
            switch (lhs.isUrgent, rhs.isUrgent) {
            case (true, false):
                return true
            case (false, true):
                return false
            case (true, true),
                (false, false):
                return lhs.creationDate > rhs.creationDate
            }
        }

        return sortedAds
    }
}
