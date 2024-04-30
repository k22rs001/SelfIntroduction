//
//  WeatherView.swift
//  SelfIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/04/29.
//

import SwiftUI
import WeatherKit    // ----①
import CoreLocation

struct weatherView: View {
    @State var currentWeather: CurrentWeather?    // ----②
    
    var body: some View {
        Form {
            if let weather = currentWeather {    // ----④
                Section {
                    // 気温
                    Label(weather.temperature.formatted(), systemImage: "thermometer")
                    // 湿度
                    Label("\(Int(weather.humidity * 100))%", systemImage: "humidity.fill")
                    // 日中か夜間か
                    Label(weather.isDaylight ? "Day time" : "Night time", systemImage: weather.isDaylight ? "sun.max.fill" : "moon.stars.fill")
                } header: {
                    HStack {
                        Spacer()
                        // 天気のシンボル
                        Image(systemName: weather.symbolName)
                            .font(.system(size: 60))
                        Spacer()
                    }
                }
            }
        }
        .task {
            // 現在の気象データを取得
            await getWeather()
        }
    }
    
    func getWeather() async {    // ----③
        let weatherService = WeatherService()
        let point = CLLocation(latitude: 35.6809591, longitude: 139.7673068) // 東京駅
        do {
            let weather = try await weatherService.weather(for: point, including: .current)    // ----④
            currentWeather = weather
        } catch {
            print(error)
        }
    }
}
