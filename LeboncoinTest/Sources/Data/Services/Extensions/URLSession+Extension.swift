//
//  URLSession+Extension.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {

    /**
     This method allows us to perform URLSession-based network calls using async/await in iOS 13 and 14
     - Even though Swift made the syntax backward compatible for previous versions, the URLSession.data(from:) hasn’t been updated.
     */
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in

                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)

                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
}
