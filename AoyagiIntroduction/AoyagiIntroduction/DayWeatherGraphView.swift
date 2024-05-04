//
//  DayWeatherGraphView.swift
//  AoyagiIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/05/04.
//

import SwiftUI
import WeatherKit
import CoreLocation
import Charts    // ----①

struct DayWeatherGraphView: View {
    @State var dayWeathers: [DayWeather] = []
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 8){
                VStack {
                    Chart(dayWeathers, id: \.self.date) { weather in
                        BarMark(
                            x: .value("日付", weather.date, unit: .day),
                            yStart: .value("最高気温", weather.highTemperature.value),
                            yEnd: .value("最低気温", weather.lowTemperature.value)
                        )
                        .foregroundStyle(Color.blue.gradient)
                        
                        PointMark(    // ----①
                            x: .value("日付", weather.date, unit: .day),
                            y: .value("最高気温", weather.highTemperature.value)
                        )
                        .annotation(position: .overlay, alignment: .bottom) {   // ----②
                            VStack(spacing: 2) {
                                // 天気のシンボルをアイコン画像で表示
                                Image(systemName: weather.symbolName)
                                // 降水確率を表示
                                Text("\(Int(weather.precipitationChance * 100))%"   ).minimumScaleFactor(0.59).padding([.bottom], 4)
                            }
                            .imageScale(.large)
                        }
                        .symbolSize(0)   // ----③
                    }
                }
                .navigationTitle("WeatherKit Sample")
                .task {
                    await getWeather()
                }
            }
        }
        .padding()
        
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
    DayWeatherGraphView()
}
