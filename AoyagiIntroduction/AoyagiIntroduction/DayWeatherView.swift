//
//  DayWeatherView.swift
//  AoyagiIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/05/07.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct DayWeatherView: View {
    @State var dayWeathers: [DayWeather] = []

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("rain")
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    VStack {
                        Text("TOKYO").font(.largeTitle)
                        Text("a")
                    }
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.8, alignment: .leading)
                    .padding(.top, 70)
                    
                    HStack {
                        VStack {
                            Text("3°").font(.largeTitle)
                            Text("a")
                        }
                        .foregroundStyle(.white)
                        .frame(width: geometry.size.width * 0.5, alignment: .leading)
                        VStack {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 1, height: 350)
                                .multilineTextAlignment(.leading)
                        }
                        VStack {
                            Text("a")
                            Text("a")
                            Text("a")
                        }
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.leading,30)
                    }
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach(dayWeathers, id: \.self.date) { weather in
                                VStack {
                                    // 曜日と日にちのフォーマット
                                    Text(formatDate(weather.date))
                                    
                                    // 降水確率
                                    Text("\(Int((weather.precipitationChance*100)))%")
                                        .padding()
                                    
                                    // 天気のシンボル
                                    Image(systemName: weather.symbolName)
                                }
                                .foregroundColor(.white)
                                .padding(.top, 150)
                            }
                        }
                        .task {
                            await getWeather()
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func getWeather() async {
        let weatherService = WeatherService()
        let location = CLLocation(latitude: 35.6809591, longitude: 139.7673068) // 東京駅
        do {
            let weather = try await weatherService.weather(for: location, including: .daily)
            dayWeathers = weather.forecast
        } catch {
            print(error)
        }
    }
    
    // 日付を曜日と日にちのみにフォーマットする関数
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d" // 曜日と日にちのみにフォーマット
        return dateFormatter.string(from: date)
    }
}

#Preview {
    DayWeatherView()
}
