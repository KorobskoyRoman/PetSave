//
//  RequestLocationView.swift
//  PetSave
//
//  Created by Roman Korobskoy on 31.01.2023.
//

import SwiftUI
import CoreLocationUI

struct RequestLocationView: View {
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack {
            Image("creature_dog-and-bone")
                .resizable()
                .frame(width: 240, height: 240)
            Text("""
            To find pets near you, first, you need to
            share your current location.
            """)
            .multilineTextAlignment(.center)

            LocationButton {
                locationManager.startUpdatingLocation()
            }
            .symbolVariant(.fill)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .onAppear {
            locationManager.updateAuthorizationStatus()
        }
    }

    func startUpdatingLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
}

struct RequestLocationView_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationView()
            .environmentObject(LocationManager())
    }
}
