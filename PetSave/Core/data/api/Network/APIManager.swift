//
//  APIManager.swift
//  PetSave
//
//  Created by Roman Korobskoy on 05.01.2023.
//

import Foundation

protocol APIManagerProtocol {
    func perform(_ request: RequestProtocol,
                 authToken: String) async throws -> Data
    func requestToken() async throws -> Data
}

final class APIManager: APIManagerProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func perform(_ request: RequestProtocol,
                 authToken: String = "") async throws -> Data {
        let urlRequest = try request.createURLRequest(authToken: authToken)
        let (data, response) = try await urlSession.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        
        return data
    }

    func requestToken() async throws -> Data {
        try await perform(AuthTokenRequest.auth)
    }
}
