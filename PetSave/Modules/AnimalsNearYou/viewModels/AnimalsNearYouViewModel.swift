//
//  AnimalsNearYouViewModel.swift
//  PetSave
//
//  Created by Roman Korobskoy on 07.01.2023.
//

import Foundation
import CoreLocation

protocol AnimalsFetcher {
    func fetchAnimals(
        page: Int,
        latitude: Double?,
        longitude: Double?
    ) async -> [Animal]
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

    func fetchAnimals(location: CLLocation?) async {
        isLoading = true
        do {
            let animals = await animalFetcher.fetchAnimals(
                page: page,
                latitude: location?.coordinate.latitude,
                longitude: location?.coordinate.longitude
            )

            try await animalStorage.save(animals: animals)
            hasMoreAnimals = !animals.isEmpty
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }

    func fetchMoreAnimals(location: CLLocation?) async {
        page += 1
        await fetchAnimals(location: location)
    }
}
