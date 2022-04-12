//
//  CategoryRepositoryTestCase.swift
//  LeboncoinTestTests
//
//  Created by Janin Culhaoglu on 12/04/2022.
//

import XCTest
@testable import LeboncoinTest

class CategoryRepositoryTestCase: XCTestCase {
    
    func test_givenCategories_whenRetrieveCategories_thenItShouldSuccess() async {
        var returnResult: [CategoryDomain]?
        
        let categories = [
            CategoryData(id: 1, name: "Véhicule"),
            CategoryData(id: 2, name: "Mode"),
            CategoryData(id: 3, name: "Bricolage"),
            CategoryData(id: 4, name: "Maison"),
            CategoryData(id: 5, name: "Loisirs"),
            CategoryData(id: 6, name: "Immobilier"),
            CategoryData(id: 7, name: "Livres/CD/DVD")
        ]
        
        let mockCategoryService = MockCategoriesService()
        let categoryRepository = CategoryRepository(categoryService: mockCategoryService)
        mockCategoryService.returnResult = categories
        
        do {
            returnResult = try await categoryRepository.retrieveCategories()
        } catch {
            XCTFail("Should be success")
        }
        
        XCTAssertEqual(returnResult?.count, 7)
    }
    
    func test_givenError_whenRetrieveCategories_thenItShouldThrowError() async {
        var returnedError: CategoryRepositoryError?
        let mockCategoryService = MockCategoriesService()
        let categoryRepository = CategoryRepository(categoryService: mockCategoryService)
        mockCategoryService.error = .badResponse
        
        do {
            _ = try await categoryRepository.retrieveCategories()
            XCTFail("Should throw an error")
        } catch {
            returnedError = error as? CategoryRepositoryError
            XCTAssertEqual(returnedError, CategoryRepositoryError.unableToFetchCategories)
        }
    }
}

// MARK: - Mocks

final class MockCategoriesService: CategoryServiceProtocol {
    var returnResult: Categories?
    var error: ServiceError = .badResponse
    
    func fetchCategories() async throws -> Categories {
        if returnResult != nil {
            return returnResult!
        } else {
            throw error
        }
    }
}
