//
//  WeatherModel.swift
//  WeatherMap
//
//  Created by Takayuki Aoyagi   on 2024/07/01.
//

import SwiftUI
import WeatherKit
import CoreLocation

class WeatherModel: ObservableObject {
    
    @Published private(set) var dayWeathers: [DayWeather] = []
    
    @Published private(set) var hourlyWeathers: [HourWeather] = []
    
    @Published private(set) var currentlyTemperature = String()
    
    @Published private(set) var currentlySymbolName = String()
    
    private let weatherService = WeatherService()
    
    private let KSULocation = CLLocation(latitude: 33.6691272, longitude: 130.4469045)
    private let HakataStation = CLLocation(latitude: 33.590188, longitude: 130.420685)
    private let TokyoStation = CLLocation(latitude: 35.6809591, longitude: 139.7673068)
    
    init() {
        fetchCurrentWeather()
    }
    
    func fetchCurrentWeather() {
        Task {
            do {
                
                let weather = try await weatherService.weather(for: HakataStation) // awaitを使ってWeatherService()からデータを取得
                currentlySymbolName = weather.currentWeather.symbolName
                
                currentlyTemperature = weather.currentWeather.temperature.formatted()
                
                let hakataWeather = try await weatherService.weather(for: HakataStation, including: .daily)
                
                let tokyoWeather = try await weatherService.weather(for: TokyoStation, including: .hourly)
                
                dayWeathers = hakataWeather.forecast
                hourlyWeathers = tokyoWeather.forecast
                //print(hourlyWeathers)
                
                
                
                //print(dayWeathers)                  
            } catch {
                print("Error fetching weather date:", error)
            }
        }
    }
}
