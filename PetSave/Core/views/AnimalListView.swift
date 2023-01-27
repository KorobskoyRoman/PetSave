//
//  AnimalListView.swift
//  PetSave
//
//  Created by Roman Korobskoy on 24.01.2023.
//

import SwiftUI

struct AnimalListView<Content, Data>: View where Content: View,
                                                 Data: RandomAccessCollection,
                                                 Data.Element: AnimalEntity {
    let animals: Data
    let footer: Content
    let router = AnimalDetailsRouter()

    init(animals: Data, @ViewBuilder footer: () -> Content) {
        self.animals = animals
        self.footer = footer()
    }

    init(animals: Data) where Content == EmptyView {
        self.init(animals: animals) {
            EmptyView()
        }
    }

    var body: some View {
        List {
            ForEach(animals) { animal in
                router.navigate(data: animal)
                {
                    AnimalRow(animal: animal)
                }
            }
            footer
        }
        .listStyle(.plain)
    }
}

struct AnimalListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnimalListView(animals: CoreDataHelper.getTestAnimalEntities() ?? [])
        }

        NavigationView {
            AnimalListView(animals: []) {
                Text("Footer")
            }
        }
    }
}
