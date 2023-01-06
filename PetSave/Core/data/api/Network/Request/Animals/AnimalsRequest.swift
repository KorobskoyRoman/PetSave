//
//  AnimalsRequest.swift
//  PetSave
//
//  Created by Roman Korobskoy on 05.01.2023.
//

import Foundation

enum AnimalsRequest: RequestProtocol {
    case getAnimalsWith(
        page: Int,
        latitude: Double?,
        longitude: Double?
    )
    case getAnimalsBy(
        name: String,
        age: String?,
        type: String?
    )

    var path: String {
        "/v2/animals"
    }

    var urlParams: [String : String?] {
        switch self {
        case .getAnimalsWith(page: let page, latitude: let latitude, longitude: let longitude):
            var params = ["page": String(page)]

            if let latitude = latitude {
                params["latitude"] = String(latitude)
            }

            if let longitude = longitude {
                params["longitude"] = String(longitude)
            }
            params["sort"] = "random"
            return params
        case .getAnimalsBy(name: let name, age: let age, type: let type):
            var params: [String: String] = [:]
            
            if !name.isEmpty {
                params["name"] = name
            }

            if let age = age {
                params["age"] = age
            }

            if let type = type {
                params["type"] = type
            }
            return params
        }
    }

    var requestType: RequestType {
        .GET
    }
}
