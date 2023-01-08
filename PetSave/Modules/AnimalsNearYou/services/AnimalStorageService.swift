//
//  AnimalStorageService.swift
//  PetSave
//
//  Created by Roman Korobskoy on 07.01.2023.
//

import CoreData

struct AnimalStorageService {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

extension AnimalStorageService: AnimalStorage {
    func save(animals: [Animal]) async throws {
        for var animal in animals {
            animal.toManagedObject(context: context)
        }

        try context.save()
    }
}
