//
//  AnimalsNearYouView.swift
//  PetSave
//
//  Created by Roman Korobskoy on 04.01.2023.
//

import SwiftUI

enum ProfileSection : String, CaseIterable {
    case list = "List"
    case map = "Map"
}

struct AnimalsNearYouView: View {
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \AnimalEntity.timestamp, ascending: true)
        ],
        animation: .default
    )
    private var animals: FetchedResults<AnimalEntity>

    @ObservedObject var viewModel: AnimalsNearYouViewModel
    @EnvironmentObject var locationManager: LocationManager
    @State var pickerValue: ProfileSection = .list

    var body: some View {
        NavigationView {
                if locationManager.locationIsDisabled {
                    RequestLocationView()
                        .navigationTitle("Animals near you")
                } else {
                    VStack {
                        Picker("", selection: $pickerValue) {
                            ForEach(ProfileSection.allCases, id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }.pickerStyle(.segmented)
                            .padding(.horizontal)

                        switch pickerValue {
                        case .list:
                            animalList
                        case .map:
                            AnimalsNearMap()
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }

    private func fetchAnimals() async {
        await viewModel.fetchAnimals(
            location: locationManager.lastSeenLocation
        )
    }

    private var animalList: some View {
        AnimalListView(animals: animals) {
            if !animals.isEmpty && viewModel.hasMoreAnimals {
                HStack(alignment: .center) {
                    LoadingAnimation()
                        .frame(maxWidth: 125, maxHeight: 125)
                    Text("Loading more animals")
                }
                .task {
                    await viewModel.fetchMoreAnimals(
                        location: locationManager.lastSeenLocation
                    )
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
            .environmentObject(LocationManager())
    }
}
