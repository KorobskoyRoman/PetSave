//
//  FetchAnimalsService.swift
//  PetSave
//
//  Created by Roman Korobskoy on 07.01.2023.
//

import Foundation

struct FetchAnimalsService {
    private let requestManager: RequestManagerProtocol

    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension FetchAnimalsService: AnimalsFetcher {
    func fetchAnimals(
        page: Int,
        latitude: Double?,
        longitude: Double?
    ) async -> [Animal] {
        let requestData = AnimalsRequest.getAnimalsWith(
            page: page,
            latitude: latitude,
            longitude: longitude
        )

        do {
            let container: AnimalsContainer = try await requestManager.perform(requestData)
            return container.animals
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
