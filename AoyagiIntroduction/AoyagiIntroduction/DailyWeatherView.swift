//
//  DailyWeatherView.swift
//  AoyagiIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/05/04.
//
import SwiftUI
import WeatherKit
import CoreLocation

struct DailyWeatherView: View {
    @State var dayWeathers: [DayWeather] = []    // ----①
    @State var selection = 0
    
    let points = [
        ["city" : "TOKYO", "latitude" : 35.6809591, "longitude" : 139.7673068],
        ["city" : "FUKUOKA", "latitude" : 33.590188 , "longitude" : 130.420685]
    ]
    
    var body: some View {
        Form {
            ForEach(dayWeathers, id: \.self.date) { weather in    // ----③
                LabeledContent {
                    // 天気
                    Text(weather.condition.description)
                    // 降水確率
                    Text("\(Int((weather.precipitationChance*100)))%")
                    // 天気のシンボル
                    Image(systemName: weather.symbolName)
                } label: {
                    // 日付
                    Text(DateFormatter.localizedString(from: weather.date, dateStyle: .long, timeStyle: .none))
                }
            }
        }
        .task {
            // 日々の気象データを取得
            await getWeather()
        }
        Picker(
            selection: $selection, label: Text("")
        ) {
            ForEach(0..<points.count, id: \.self) { index in
                if let city = points[index]["city"] as? String {
                    Text(city).tag(index)
                }
            }
        }
        .pickerStyle(WheelPickerStyle())
        //値を監視対象に設定
        .onChange(of: selection) {
            Task {
                await getWeather()
            }
        }
    }
    
    
    func getWeather() async {
        let weatherService = WeatherService()
        guard let selectedCityIndex = points.indices.contains(selection) ? selection : nil,
              let latitude = points[selectedCityIndex]["latitude"] as? Double,
              let longitude = points[selectedCityIndex]["longitude"] as? Double else {
            return
        }
        let location = CLLocation(latitude: latitude, longitude: longitude) // 東京駅と博多駅
        do {
            let weather = try await weatherService.weather(for: location, including: .daily)    // ----②
            dayWeathers = weather.forecast
        } catch {
            print(error)
        }
    }
}

#Preview {
    DailyWeatherView()
}
