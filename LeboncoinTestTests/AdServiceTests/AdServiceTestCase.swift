//
//  AdServiceTestCase.swift
//  LeboncoinTestTests
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import XCTest
@testable import LeboncoinTest

class AdServiceTestCase: XCTestCase {

    func testFetchAdsShouldReturnAdsIfNoErrorAndCorrectData() async {
        var returnedData: Ads?

        let mockAdService = AdService(networkClient: NetworkClient(
            session: URLSessionFake(
                data: FakeResponseData.createCorrectData(fileName: "Listing"),
                response: FakeResponseData.responseOK,
                error: nil)))

        do {
            returnedData = try await mockAdService.fetchAds()
        } catch {
            XCTFail("Should be success")
        }

        XCTAssertEqual(returnedData?.count, 4)
        XCTAssertEqual(returnedData?.first?.title, "Sony Ericsson Xperia Arc S + coque (occasion)")
    }

    func testFetchAdsShouldFailIfResponseKO() async {
        let mockAdService = AdService(networkClient: NetworkClient(
            session: URLSessionFake(
                data: FakeResponseData.createCorrectData(fileName: "Listing"),
                response: FakeResponseData.responseKO,
                error: nil)))

        do {
            _ = try await mockAdService.fetchAds()
            XCTFail("Should fail")
        } catch {
            XCTAssertEqual(error as? ServiceError, .badResponse)
        }
    }
    
    func testFetchAdsShouldFailIfIncorrectData() async {
        let mockAdService = AdService(networkClient: NetworkClient(
            session: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil)))

        do {
            _ = try await mockAdService.fetchAds()
            XCTFail("Should fail")
        } catch {
            XCTAssertEqual(error as? ServiceError, .unableToDecodeJSON)
        }
    }
}
