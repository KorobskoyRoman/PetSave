//
//  AnimalsNearYouView.swift
//  PetSave
//
//  Created by Roman Korobskoy on 04.01.2023.
//

import SwiftUI

struct AnimalsNearYouView: View {
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \AnimalEntity.timestamp, ascending: true)
        ],
        animation: .default
    )
    private var animals: FetchedResults<AnimalEntity>

    @ObservedObject var viewModel: AnimalsNearYouViewModel

    var body: some View {
        NavigationView {
            AnimalListView(animals: animals) {
                if !animals.isEmpty && viewModel.hasMoreAnimals {
                    ProgressView("Finding more animals...")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .task {
                            await viewModel.fetchMoreAnimals()
                        }
                }
            }
            .task {
                await fetchAnimals()
            }
            .listStyle(.plain)
            .navigationTitle("Animals near you")
            .overlay {
                if viewModel.isLoading && animals.isEmpty{
                    ProgressView("Finding Animals near you...\nPlease wait!")
                        .multilineTextAlignment(.center)
                }
            }
            .refreshable {
                await fetchAnimals()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }

    private func fetchAnimals() async {
        await viewModel.fetchAnimals()
    }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = AnimalsNearYouViewModel(
            animalFetcher: AnimalsFetcherMock(),
            animalStorage: AnimalStorageService(context: CoreDataHelper.previewContext)
        )
        AnimalsNearYouView(viewModel: vm)
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext)
    }
}
