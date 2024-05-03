//
//  WeatherView.swift
//  SelfIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/04/29.
//

import SwiftUI
import WeatherKit    // ----①
import CoreLocation

struct WeatherView: View {
    @State var currentWeather: CurrentWeather?    // ----②
    @State var selection = 0
    let points = [
        ["city" : "TOKYO", "latitude" : 35.6809591, "longitude" : 139.7673068],
        ["city" : "FUKUOKA", "latitude" : 33.590188 , "longitude" : 130.420685]
    ]
    
    //var numbers : [Int] = [1,2,3,4,5]
    
    var body: some View {
        VStack {
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
                                .font(.system(size: 64))
                            Spacer()
                        }
                    }
                }
            }
            .task {
                // 現在の気象データを取得
                await getWeather()
            }
            Picker(
                selection: $selection, label: Text("Animal")
            ) {
                //                ForEach(numbers, id: \.self){ number in
                //                    Text("\(number)")
                //                }
                //
                ForEach(0..<points.count, id: \.self) { index in
                    if let city = points[index]["city"] as? String {
                        Text(city).tag(index)
                    }
                }
                //                Text("Dog 🐶").tag(0)
                //                Text("Cat 🐱").tag(1)
                //                Text("Rabbit 🐰").tag(2)
                //                Text("Turtle 🐢").tag(3)
                //                Text("Rizard 🦎").tag(4)
                //                Text("Snake 🐍").tag(5)
            }
            .pickerStyle(WheelPickerStyle())
        }
        
    }
    
    func getWeather() async {    // ----③
        let weatherService = WeatherService()
        //選択された都市の座標を取得
        guard let selectedCityIndex = points.indices.contains(selection) ? selection : nil,
              let latitude = points[selectedCityIndex]["latitude"] as? Double,
              let longitude = points[selectedCityIndex]["longitude"] as? Double else {
            return
        }
        let point = CLLocation(latitude: latitude, longitude: longitude) // 東京駅と博多駅
        do {
            let weather = try await weatherService.weather(for: point, including: .current)    // ----④
            currentWeather = weather
        } catch {
            print(error)
        }
    }
}

#Preview {
    WeatherView()
}
