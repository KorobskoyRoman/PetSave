//
//  AnimalSearchMock.swift
//  PetSave
//
//  Created by Roman Korobskoy on 24.01.2023.
//

import Foundation

struct AnimalSearchMock: AnimalSearcher {
    func searchAnimal(
        by text: String,
        age: AnimalSearchAge,
        type: AnimalSearchType
    ) async -> [Animal] {
        var animals = Animal.mock

        if age != .none {
            animals = animals.filter({
                $0.age.rawValue.lowercased() == age.rawValue.lowercased()
            })
        }

        if type != .none {
            animals = animals.filter {
                $0.type.lowercased() == type.rawValue.lowercased()
            }
        }

        return animals.filter { $0.name.contains(text) }
    }
}
