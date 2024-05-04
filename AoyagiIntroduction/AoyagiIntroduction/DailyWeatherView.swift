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
    }
    
    func getWeather() async {
        let weatherService = WeatherService()
        let location = CLLocation(latitude: 35.6809591, longitude: 139.7673068) // 東京駅
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
