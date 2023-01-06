//
//  AnimalsRequestMock.swift
//  PetSaveTests
//
//  Created by Roman Korobskoy on 05.01.2023.
//

import Foundation

@testable import PetSave

enum AnimalsRequestMock: RequestProtocol {
    case getAnimals

    var requestType: RequestType {
        return .GET
    }

    var path: String {
        guard let path = Bundle.main.path(forResource: "AnimalsMock", ofType: "json") else { return "" }
        return path
    }
}
