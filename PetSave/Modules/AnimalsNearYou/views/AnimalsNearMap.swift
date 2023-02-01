//
//  AnimalsNearMap.swift
//  PetSave
//
//  Created by Roman Korobskoy on 31.01.2023.
//

import SwiftUI
import MapKit

struct AnimalsNearMap: View {
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \AnimalEntity.timestamp, ascending: true)
        ],
        animation: .default
    )
    private var animals: FetchedResults<AnimalEntity>
    
    @StateObject var addressFetcher = AddressFetcher()
    @StateObject var locationManager = LocationManager()

    var body: some View {
        Map(
            coordinateRegion: $addressFetcher.coordinates,
            annotationItems: animals
        ) { _ in
            MapPin(
                coordinate: CLLocationCoordinate2D(
                    latitude: addressFetcher.coordOnMap.latitude,
                    longitude: addressFetcher.coordOnMap.longitude
                )
            )
        }
        .task {
            await addressFetcher.searchOnMap(by: animals)
        }
    }
}

struct AnimalsNearMap_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsNearMap()
    }
}
