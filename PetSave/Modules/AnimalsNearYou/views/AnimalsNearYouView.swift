//
//  AnimalsNearYouView.swift
//  PetSave
//
//  Created by Roman Korobskoy on 04.01.2023.
//

import SwiftUI

struct AnimalsNearYouView: View {
    @State var animals: [Animal] = []
    @State var isLoading = true

    private let requestManager = RequestManager()

    var body: some View {
        NavigationView {
            List {
                ForEach(animals) { animal in
                    AnimalRow(animal: animal)
                }
            }
            .task {
                await fetchAnimals()
            }
            .listStyle(.plain)
            .navigationTitle("Animals near you")
            .overlay {
                if isLoading {
                    ProgressView("Finding Animals near you...\n Please wait!")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }

    @MainActor
    func stopLoading() async {
        isLoading = false
    }

    func fetchAnimals() async {
        do {
            let animalsContainer: AnimalsContainer = try await requestManager
                .perform(AnimalsRequest.getAnimalsWith(page: 1,
                                                       latitude: nil,
                                                       longitude: nil))
            self.animals = animalsContainer.animals
            await stopLoading()
        } catch {
            print(error)
        }
    }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsNearYouView(animals: Animal.mock, isLoading: false)
    }
}
