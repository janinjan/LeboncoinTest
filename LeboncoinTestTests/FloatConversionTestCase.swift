//
//  FloatConversionTestCase.swift
//  LeboncoinTestTests
//
//  Created by Janin Culhaoglu on 11/04/2022.
//

import XCTest
@testable import LeboncoinTest

class FloatConversionTestCase: XCTestCase {

    func test_givenFloatNumberWithTrailingZero_whenCleanValue_thenItShouldRemoveTheDecimal() {
        let price: Float = 15.0

        let priveValue = price.cleanValue

        XCTAssertEqual(priveValue, "15")
    }

    func test_givenFloatNumberWithoutTrailingZero_whenCleanValue_thenItShouldNotRemoveTheDecimal() {
        let price: Float = 15.5

        let priveValue = price.cleanValue

        XCTAssertEqual(priveValue, "15.5")
    }
}
