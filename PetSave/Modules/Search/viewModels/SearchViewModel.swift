//
//  SearchViewModel.swift
//  PetSave
//
//  Created by Roman Korobskoy on 24.01.2023.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var ageSelection = AnimalSearchAge.none
    @Published var typeSelection = AnimalSearchType.none

    var shouldFilter: Bool {
        !searchText.isEmpty ||
        ageSelection != .none ||
        typeSelection != .none
    }

    private let animalSearcher: AnimalSearcher
    private let animalStorage: AnimalStorage

    init(animalSearcher: AnimalSearcher, animalStorage: AnimalStorage) {
        self.animalSearcher = animalSearcher
        self.animalStorage = animalStorage
    }

    func search() {
        Task {
            let animals = await animalSearcher.searchAnimal(
                by: searchText,
                age: ageSelection,
                type: typeSelection
            )

            do {
                try await animalStorage.save(animals: animals)
            } catch {
                print("Storing animals error \(error.localizedDescription)")
            }
        }
    }

    func clearFilters() {
        typeSelection = .none
        ageSelection = .none
    }

    func selectTypeSuggestion(_ type: AnimalSearchType) {
        typeSelection = type
        search()
    }
}
