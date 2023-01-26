//
//  OnboardingBackgroundView.swift
//  PetSaveOnboarding
//
//  Created by Roman Korobskoy on 25.01.2023.
//

import SwiftUI

struct OnboardingBackgroundView: View {
    let backgroundePets = Pet.backgroundPets

    var body: some View {
        ZStack {
            ForEach(backgroundePets) { pet in
                pet.petImage
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .position(pet.position)
            }
        }
    }
}

struct OnboardingBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingBackgroundView()
    }
}
