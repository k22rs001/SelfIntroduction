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
    @State var dayWeathers: [DayWeather] = []    // ----①
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                
                Image("rain")
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .frame(width: geometry.size.width, height: geometry.size.height)     // フレームサイズの指定
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    VStack{
                        Text("TOKYO").font(.largeTitle)
                        Text("a")
                    }
                    .frame(width: geometry.size.width * 0.9,alignment: .leading)
                    .padding()
                    
                    HStack{
                        VStack{
                            Text("3").font(.largeTitle)
                            Text("a")
                        }
                        .frame(width: geometry.size.width * 0.6, alignment: .leading)
                        VStack{
                            Text("a")
                            Text("a")
                            Text("a")
                        }
                    }
                    ScrollView (.horizontal) {
                        HStack{
                            ForEach(dayWeathers, id: \.self.date) { weather in    // ----③
                                VStack {
                                    // 日付
                                    Text(DateFormatter.localizedString(from: weather.date, dateStyle: .long, timeStyle: .none))
                                        .foregroundStyle(.black)
                                    Text(weather.condition.description)
                                        .foregroundStyle(.black)
                                    // 降水確率
                                    Text("\(Int((weather.precipitationChance*100)))%")
                                    
                                    // 天気のシンボル
                                    Image(systemName: weather.symbolName)
                                }
                                .padding()
                                .background()
                            }
                        }
                        .task {
                            // 日々の気象データを取得
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
            let weather = try await weatherService.weather(for: location, including: .daily)    // ----②
            dayWeathers = weather.forecast
        } catch {
            print(error)
        }
    }
}

#Preview {
    DayWeatherView()
}
