//
//  AnimalsNearYouViewModel.swift
//  PetSave
//
//  Created by Roman Korobskoy on 07.01.2023.
//

import Foundation

protocol AnimalsFetcher {
    func fetchAnimals(page: Int) async -> [Animal]
}

protocol AnimalStorage {
    func save(animals: [Animal]) async throws
}

@MainActor
final class AnimalsNearYouViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var hasMoreAnimals = true

    private let animalFetcher: AnimalsFetcher
    private let animalStorage: AnimalStorage

    private(set) var page = 1

    init(
        isLoading: Bool = true,
        animalFetcher: AnimalsFetcher,
        animalStorage: AnimalStorage
    ) {
        self.isLoading = isLoading
        self.animalFetcher = animalFetcher
        self.animalStorage = animalStorage
    }

    func fetchAnimals() async {
        isLoading = true
        let animals = await animalFetcher.fetchAnimals(page: page)

        do {
            try await animalStorage.save(animals: animals)
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
        hasMoreAnimals = !animals.isEmpty
    }

    func fetchMoreAnimals() async {
        page += 1
        await fetchAnimals()
    }
}
