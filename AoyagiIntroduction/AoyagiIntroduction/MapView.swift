//
//  MapView.swift
//  AoyagiIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/07/01.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let hakataStation = CLLocationCoordinate2D(latitude: 33.590188, longitude: 130.420685)
}

struct MapView: View {
    @StateObject private var weatherModel = WeatherModel()
    var body: some View {
        Map {
            Marker("HakataStation",
                   systemImage: weatherModel.currentlySymbolName,
                   coordinate: .hakataStation)
        }
    }
}

#Preview {
    MapView()
}
