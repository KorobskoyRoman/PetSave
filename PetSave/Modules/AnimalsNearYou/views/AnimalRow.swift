//
//  AnimalRow.swift
//  PetSave
//
//  Created by Roman Korobskoy on 05.01.2023.
//

import SwiftUI

struct AnimalRow: View {
    let animal: AnimalEntity

    var body: some View {
        HStack {
            AsyncImage(url: animal.picture) { image in
                image
                    .resizable()
            } placeholder: {
                let img = animal.type == "Cat" ? Image("defCat") : Image("defDog")
                img
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        if animal.picture != nil {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.gray.opacity(0.4))
                        }
                    }
            }
//            .aspectRatio(contentMode: .fit)
            .frame(width: 112, height: 112)
//            .cornerRadius(8)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(animal.name ?? "N/A")
                    .multilineTextAlignment(.center)
                    .font(.title3)
            }
            .lineLimit(1)
        }
    }
}

struct AnimalRow_Previews: PreviewProvider {
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            AnimalRow(animal: animal)
        }
    }
}
