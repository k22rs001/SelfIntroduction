//
//  WeatherModelView.swift
//  AoyagiIntroduction
//
//  Created by Takayuki Aoyagi   on 2024/07/01.
//

import SwiftUI

struct WeatherModelView: View {
    @StateObject private var weatherModel = WeatherModel()
    var body: some View {
//        Text("\(weatherModel.dayWeathers)")
//       Form {
//           ForEach(weatherModel.dayWeathers, id: \.self.date) { weather in    // ----③
//                LabeledContent {
//                    // 天気
//                    Text(weather.condition.description)
//                    // 降水確率
//                    Text("\(Int((weather.precipitationChance*100)))%")
//                    // 天気のシンボル
//                    Image(systemName: weather.symbolName)
//                } label: {
//                    // 日付
//                    Text(DateFormatter.localizedString(from: weather.date, dateStyle: .long, timeStyle: .none))
//                }
//            }
//        }
        Form {
            ForEach(weatherModel.hourlyWeathers, id: \.self.date) { weather in    // ----③
                 LabeledContent {
                     // 天気
                     Text(weather.condition.description)
                     // 降水確率
                     Text("\(Int((weather.precipitationChance*100)))%")
                     // 天気のシンボル
                     Image(systemName: weather.symbolName)
                 } label: {
                     // 日付
//                     Text(DateFormatter.localizedString(from: weather.date, dateStyle: .long, timeStyle: .none))
                     Text("\(weather.date)")
                 }
             }
         }

    }
}

#Preview {
    WeatherModelView()
}
