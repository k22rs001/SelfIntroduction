//
//  temperatureView.swift
//  AoyagiIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/07/10.
//

import SwiftUI

struct temperatureView: View {
    @StateObject private var weatherModel = WeatherModel()
    var body: some View {
        VStack {
            Text("現在地")
            Text(weatherModel.currentlyTemperature)
        }
    }
}

#Preview {
    temperatureView()
}
