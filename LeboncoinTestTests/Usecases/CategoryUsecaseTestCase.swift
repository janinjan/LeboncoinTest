//
//  CategoryUsecaseTestCase.swift
//  LeboncoinTestTests
//
//  Created by Janin Culhaoglu on 12/04/2022.
//

import XCTest
@testable import LeboncoinTest

class CategoryUsecaseTestCase: XCTestCase {
    
    func test_givenCategories_whenRetrieveCategories_thenItShouldReturnCategories() async {
        let categories = [
            createCategories(id: 1, name: "Véhicule"),
            createCategories(id: 2, name: "Mode"),
            createCategories(id: 3, name: "Bricolage")
        ]
        let mockCatgoryRepository = MockCategoryRepository()
        mockCatgoryRepository.returnResult = categories
        let categoryUsecase = CategoryUsecase(repository: mockCatgoryRepository)
        
        let fetchedCategories = await categoryUsecase.retrieveCategories()
        
        XCTAssertEqual(fetchedCategories.count, 3)
    }
    
    func test_givenError_whenRetrieveCategories_thenItShouldReturnEmptyCategories() async {
        let mockCatgoryRepository = MockCategoryRepository()
        mockCatgoryRepository.error = .unableToFetchCategories
        let categoryUsecase = CategoryUsecase(repository: mockCatgoryRepository)
        
        let fetchedCategories = await categoryUsecase.retrieveCategories()
        
        XCTAssertTrue(fetchedCategories.isEmpty)
    }
    
    private func createCategories(id: Int, name: String) -> CategoryDomain {
        return CategoryDomain(id: id, name: name)
    }
}

// MARK: - Mocks

final class MockCategoryRepository: CategoryRepositoryProtocol {
    var returnResult: [CategoryDomain]?
    var error: CategoryRepositoryError = .unableToFetchCategories
    
    func retrieveCategories() async throws -> [CategoryDomain] {
        if returnResult != nil {
            return returnResult!
        } else {
            throw error
        }
    }
}
