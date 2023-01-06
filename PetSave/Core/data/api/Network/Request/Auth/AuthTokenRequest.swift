//
//  AuthTokenRequest.swift
//  PetSave
//
//  Created by Roman Korobskoy on 05.01.2023.
//

import Foundation

enum AuthTokenRequest: RequestProtocol {
    case auth

    var path: String {
        "/v2/oauth2/token"
    }

    var params: [String : Any] {
        [
            "grant_type": APIConstants.grantType,
            "client_id": APIConstants.clientId,
            "client_secret": APIConstants.clientSecret
        ]
    }

    var addAuthToken: Bool {
        false
    }

    var requestType: RequestType {
        .POST
    }
}
