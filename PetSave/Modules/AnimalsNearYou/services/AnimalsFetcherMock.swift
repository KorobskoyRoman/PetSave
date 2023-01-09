//
//  AnimalsFetcherMock.swift
//  PetSave
//
//  Created by Roman Korobskoy on 07.01.2023.
//

import Foundation

struct AnimalsFetcherMock: AnimalsFetcher {
    func fetchAnimals(page: Int) async -> [Animal] {
        Animal.mock
    }
}
