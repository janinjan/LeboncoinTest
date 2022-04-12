//
//  FakeResponseData.swift
//  LeboncoinTestTests
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

class FakeResponseData {

    // MARK: - Data

    static func createCorrectData(fileName: String) -> Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: fileName, withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static let incorrectData = "error".data(using: .utf8)!

    // MARK: - Response

    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://www.leboncoin.fr")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://www.leboncoin.fr")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])

    // MARK: - Error

    class SimulateError: Error {}
    static let error = SimulateError()
}
