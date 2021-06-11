//
//  weatherModel.swift
//  Weather App
//
//  Created by Sawyer Cherry on 6/10/21.
//

import Foundation

struct WeatherData: Decodable {
    var name: String
    var main: MainWeatherData
}

struct MainWeatherData: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
    
}
