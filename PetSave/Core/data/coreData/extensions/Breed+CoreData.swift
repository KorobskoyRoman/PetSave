//
//  Breed+CoreData.swift
//  PetSave
//
//  Created by Roman Korobskoy on 06.01.2023.
//

import CoreData

extension Breed: CoreDataPersistable {
    var keyMap: [PartialKeyPath<Breed> : String] {
        [
             \.primary: "primary",
             \.secondary: "secondary",
             \.mixed: "mixed",
             \.unknown: "unknown",
             \.id: "id"
        ]
    }

    typealias ManagedType = BreedEntity
}
