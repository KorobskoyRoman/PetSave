//
//  OnboardingView.swift
//  PetSaveOnboarding
//
//  Created by Roman Korobskoy on 25.01.2023.
//

import SwiftUI

struct OnboardingView: View {
    let onboarding: OnboardingModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .circular)
                .fill(.white)
                .shadow(radius: 12)
                .padding(.horizontal, 20)

            OnboardingVStack(onboarding: onboarding)
        }
    }
}

struct OnboardingVStack: View {
    let onboarding: OnboardingModel

    var body: some View {
        VStack(alignment: .center) {
            VStack {
                Text(onboarding.title)
                    .foregroundColor(.rwDark)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)

                Text(onboarding.description)
                    .foregroundColor(.rwDark)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom], 10)
                    .padding(.horizontal, 10)

                onboarding.image
                    .resizable()
                    .frame(width: 140, height: 140, alignment: .center)
                    .foregroundColor(.rwDark)
                    .aspectRatio(contentMode: .fit)
            }
            .padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboarding: OnboardingModel(
            title: "Title",
            description: "Descr",
            image: .bird)
        )
    }
}
