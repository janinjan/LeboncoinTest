//
//  NetworkClient.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

class NetworkClient: NetworkClientProtocol {

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Initializer

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Methods

    func getServiceResponse<T: Codable>(request: HTTPRequestProtocol, scheme: String, host: String) async throws -> (T) {
        let request = createURLRequest(for: request, scheme: scheme, host: host)

        guard let url = request?.url else {
            throw ServiceError.unableToCreateRequest
        }

        let (data, response) = try await session.data(from: url)

        guard let response = (response as? HTTPURLResponse), response.statusCode.isValidHttpsStatus else {
            throw ServiceError.badResponse
        }

        guard let data = try? JSONDecoder().decode(T.self, from: data) else {
            throw ServiceError.unableToDecodeJSON
        }

        return data
    }

    private func createURLRequest(for request: HTTPRequestProtocol, scheme: String, host: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = request.path

        guard let url = components.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        return urlRequest
    }
}

private extension Int {

    var isValidHttpsStatus: Bool {
        switch self {
        case 200..<400:
            return true
        default:
            return false
        }
    }
}
