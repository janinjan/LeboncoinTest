//
//  CategoryServiceTestCase.swift
//  LeboncoinTestTests
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import XCTest
@testable import LeboncoinTest

class CategoryServiceTestCase: XCTestCase {

    func testFetchCategoriesShouldReturnCategoriesIfNoErrorAndCorrectData() async {
        var returnedData: Categories?

        let mockCategoryService = CategoryService(networkClient: NetworkClient(
            session: URLSessionFake(
                data: FakeResponseData.createCorrectData(fileName: "Categories"),
                response: FakeResponseData.responseOK,
                error: nil)))

        do {
            returnedData = try await mockCategoryService.fetchCategories()
        } catch {
            XCTFail("Should be success")
        }

        XCTAssertEqual(returnedData?.count, 11)
    }

    func testFetchCategoriesShouldFailIfResponseKO() async {
        let mockCategoryService = CategoryService(networkClient: NetworkClient(
            session: URLSessionFake(
                data: FakeResponseData.createCorrectData(fileName: "Categories"),
                response: FakeResponseData.responseKO,
                error: nil)))

        do {
            _ = try await mockCategoryService.fetchCategories()
            XCTFail("Should fail")
        } catch {
            XCTAssertEqual(error as? ServiceError, .badResponse)
        }
    }

    func testFetchCategoriesShouldFailIfIncorrectData() async {
        let mockCategoryService = CategoryService(networkClient: NetworkClient(
            session: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil)))

        do {
            _ = try await mockCategoryService.fetchCategories()
            XCTFail("Should fail")
        } catch {
            XCTAssertEqual(error as? ServiceError, .unableToDecodeJSON)
        }
    }
}
