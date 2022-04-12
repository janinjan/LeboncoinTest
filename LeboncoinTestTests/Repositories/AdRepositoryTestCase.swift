//
//  AdRepositoryTestCase.swift
//  LeboncoinTestTests
//
//  Created by Janin Culhaoglu on 12/04/2022.
//

import XCTest
@testable import LeboncoinTest

class AdRepositoryTestCase: XCTestCase {
    
    func test_givenAdsAndCategories_whenRetrieveAds_thenItShouldAddCategoryNameToAds() async {
        var returnResult: [AdDomain]?
        let mockAdService = MockAdService()
        let mockCategoryService = MockCategoryService()
        let adRepository = AdRepository(adService: mockAdService, categoryService: mockCategoryService)
        
        do {
            returnResult = try await adRepository.retrieveAds()
        } catch {
            XCTFail("Should be success")
        }
        
        let adData1 = returnResult?[0]
        let adData2 = returnResult?[1]
        let adData3 = returnResult?[2]
        let adData4 = returnResult?[3]
        
        XCTAssertEqual(adData1?.categoryName, "Bricolage", "Porte blindée")
        XCTAssertEqual(adData2?.categoryName, "Véhicule", "Casque Moto")
        XCTAssertEqual(adData3?.categoryName, "Mode", "Bonnets rouge tricotés mains")
        XCTAssertEqual(adData4?.categoryName, "Mode", "Pull bleu coton")
    }
}

// MARK: - Mocks

final class MockCategoryService: CategoryServiceProtocol {
    
    func fetchCategories() async throws -> Categories {
        return [
            CategoryData(id: 1, name: "Véhicule"),
            CategoryData(id: 2, name: "Mode"),
            CategoryData(id: 3, name: "Bricolage")
        ]
    }
}

final class MockAdService: AdsServiceProtocol {
    
    func fetchAds() async throws -> Ads {
        return [
            createAdData(id: 1, categoryID: 3, title: "Porte blindée"),
            createAdData(id: 2, categoryID: 1, title: "Casque Moto"),
            createAdData(id: 3, categoryID: 2, title: "Bonnets rouge tricotés mains"),
            createAdData(id: 4, categoryID: 2, title: "Pull bleu coton")
        ]
    }
    
    private func createAdData(id: Int, categoryID: Int, title: String) -> AdData {
        return AdData(id: id, categoryID: categoryID,
                      title: title,
                      description: "",
                      price: 10.0,
                      imagesURL: AdDataImagesURL(small: nil, thumb: nil),
                      creationDate: "",
                      isUrgent: false,
                      siret: nil)
    }
}
