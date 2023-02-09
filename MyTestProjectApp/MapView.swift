//
//  MapView.swift
//  MyTestProjectApp
//
//  Created by Nikita Marton on 13.10.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50.6343297912734,
                                           longitude: 36.441697647370546),
            latitudinalMeters: 1500,
            longitudinalMeters: 1500
        )
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.top)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
