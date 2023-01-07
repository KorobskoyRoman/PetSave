//
//  AnimalsNearYouView.swift
//  PetSave
//
//  Created by Roman Korobskoy on 04.01.2023.
//

import SwiftUI

struct AnimalsNearYouView: View {
    @State var isLoading = true
    @SectionedFetchRequest<String, AnimalEntity>(
        sectionIdentifier: \AnimalEntity.animalSpecies,
        sortDescriptors: [
            NSSortDescriptor(keyPath: \AnimalEntity.timestamp,
                             ascending: true)
        ],
        animation: .default
    )
    private var sectionedAnimals: SectionedFetchResults<String, AnimalEntity>

    private let requestManager = RequestManager()

    var body: some View {
        NavigationView {
            List {
                ForEach(sectionedAnimals) { animals in
                    Section {
                        ForEach(animals) { animal in
                            NavigationLink(destination: AnimalDetailsView()) {
                                AnimalRow(animal: animal)
                            }
                        }
                    } header: {
                        Text(animals.id)
                    }

                }
            }
            .task {
                await fetchAnimals()
            }
            .listStyle(.plain)
            .navigationTitle("Animals near you")
            .overlay {
                if isLoading {
                    ProgressView("Finding Animals near you...\nPlease wait!")
                        .multilineTextAlignment(.center)
                }
            }
            .refreshable {
                await fetchAnimals()
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
                .perform(
                    AnimalsRequest.getAnimalsWith(
                        page: 1,
                        latitude: nil,
                        longitude: nil
                    )
                )

            for var animal in animalsContainer.animals {
                animal.toManagedObject()
            }

            await stopLoading()
        } catch {
            print(error)
        }
    }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsNearYouView(isLoading: false)
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext)
    }
}
