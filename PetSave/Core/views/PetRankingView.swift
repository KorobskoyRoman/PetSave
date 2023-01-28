//
//  PetRankingView.swift
//  PetSave
//
//  Created by Roman Korobskoy on 27.01.2023.
//

import SwiftUI

struct PetRankingView: View {
    @ObservedObject var viewModel: PetRankingViewModel
    var animal: AnimalEntity

    init(animal: AnimalEntity) {
        self.animal = animal
        viewModel = PetRankingViewModel(animal: animal)
    }

    var body: some View {
        HStack {
            Text("Rank me!")
                .multilineTextAlignment(.center)
            ForEach(0...4, id: \.self) { index in
                PetRankImage(index: index, recentIndex: $viewModel.ranking)
            }
        }
    }
}

struct PetRankImage: View {
    let index: Int
    @State var opacity: Double = 0.4
    @State var tapped = false
    @Binding var recentIndex: Int

    var body: some View {
        Image("creature_dog-and-bone")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(opacity)
            .frame(width: 50, height: 50)
            .onTapGesture {
                opacity = tapped ? 0.4 : 1.0
                tapped.toggle()
                recentIndex = index
            }
            .onChange(of: recentIndex) { value in
                checkOpacity(value: value)
            }
            .onAppear {
                checkOpacity(value: recentIndex)
            }
    }

    func checkOpacity(value: Int) {
        opacity = value >= index ? 1.0 : 0.4
        tapped.toggle()
    }
}

final class PetRankingViewModel: ObservableObject {
    var animal: AnimalEntity
    var ranking: Int {
        didSet {
            animal.ranking = Int32(ranking)
            objectWillChange.send()
        }
    }
    
    init(animal: AnimalEntity) {
        self.animal = animal
        self.ranking = Int(animal.ranking)
    }
}

struct PetRankingView_Previews: PreviewProvider {
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            PetRankingView(animal: animal)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
