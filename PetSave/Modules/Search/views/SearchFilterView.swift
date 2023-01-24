//
//  SearchFilterView.swift
//  PetSave
//
//  Created by Roman Korobskoy on 24.01.2023.
//

import SwiftUI

struct SearchFilterView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        Form {
            Section {
                Picker("Age", selection: $viewModel.ageSelection) {
                    ForEach(AnimalSearchAge.allCases, id: \.self) { age in
                        Text(age.rawValue.capitalized)
                    }
                }
                .onChange(of: viewModel.ageSelection) { _ in
                    viewModel.search()
                }

                Picker("Type", selection: $viewModel.typeSelection) {
                    ForEach(AnimalSearchType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                .onChange(of: viewModel.typeSelection) { _ in
                    viewModel.search()
                }
            } footer: {
                Text("Tip!: You can mix both, age and type, to make more accurate search.")
            }

            Button("Clear", role: .destructive) {
                viewModel.clearFilters()
            }

            Button("Done") {
                dismiss()
            }
        }
        .navigationTitle("Filters")
        .toolbar {
            ToolbarItem {
                Button {
                    dismiss()
                } label: {
                    Label("Close", systemImage: "xmark.circle.fill")
                }
            }
        }
    }
}

struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext

        NavigationView {
            SearchFilterView(viewModel: SearchViewModel(animalSearcher: AnimalSearchMock(), animalStorage: AnimalStorageService(context: context)))
        }
    }
}
