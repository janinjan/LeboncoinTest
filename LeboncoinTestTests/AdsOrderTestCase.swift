//
//  AdsOrderTestCase.swift
//  LeboncoinTestTests
//
//  Created by Janin Culhaoglu on 11/04/2022.
//

import XCTest
@testable import LeboncoinTest

class AdsOrderTestCase: XCTestCase {

    func test_GivenAds_whenRetrieveAds_thenItShoulSortAdsByUrgencyAndDate() async {
        let mockAdRepository: AdRepositoryProtocol = MockAdRepository()
        let adUsecase = AdUsecase(repository: mockAdRepository)

        let filteredAds = await adUsecase.retrieveAds()

        XCTAssertEqual(filteredAds.first?.id, 5)
    }

    func test_GivendAds_whenRetrieveAds_thenItShouldSortAdsByDate() async {
        let mockAdRepository: AdRepositoryProtocol = MockAdRepository()
        let adUsecase = AdUsecase(repository: mockAdRepository)

        let filteredAds = await adUsecase.retrieveAds()

        XCTAssertEqual(filteredAds[0].id, 5, "id 5 is urgent, date: Nov 6 at 11:19")
        XCTAssertEqual(filteredAds[1].id, 3, "id 3 is urgent, date: Nov 5 at 15:56:32")
        XCTAssertEqual(filteredAds[2].id, 4, "id 4 is not urgent, date: Nov 6 at 11:18:02")
        XCTAssertEqual(filteredAds[3].id, 1, "id 1 is not urgent, date: Nov 5 at 15:56:50")
        XCTAssertEqual(filteredAds[4].id, 2, "id 2 is not urgent, date Oct 1 at 10:35")
    }
}

final class MockAdRepository: AdRepositoryProtocol {

    let dateInput1 = "2019-11-05T15:56:50+0000"
    let dateInput2 = "2019-10-01T10:35:02+0000"
    let dateInput3 = "2019-11-05T15:56:32+0000"
    let dateInput4 = "2019-11-06T11:18:02+0000"
    let dateInput5 = "2019-11-06T11:19:44+0000"

    private func createAd(id: Int, date: Date, isUrgent: Bool) -> AdDomain {
        return AdDomain(id: id, categoryName: "", title: "", description: "", price: 0.0,
                        imageSmallURL: nil, imageThumbURL: nil, creationDate: date, isUrgent: isUrgent)
    }

    func retrieveAds() async throws -> [AdDomain] {
        [
            createAd(id: 1, date: dateInput1.toDateFromISO8601, isUrgent: false),
            createAd(id: 2, date: dateInput2.toDateFromISO8601, isUrgent: false),
            createAd(id: 3, date: dateInput3.toDateFromISO8601, isUrgent: true),
            createAd(id: 4, date: dateInput4.toDateFromISO8601, isUrgent: false),
            createAd(id: 5, date: dateInput4.toDateFromISO8601, isUrgent: true)
        ]
    }
}
