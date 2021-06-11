//
//  ContentView.swift
//  Weather App
//
//  Created by Sawyer Cherry on 6/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var data = WeatherData(name: "", main: MainWeatherData(temp: 0.0, feels_like: 0, temp_min: 0, temp_max: 0, pressure: 0, humidity: 0))
    @State var weatherUrl = String()
    @State var searchString = String()
    @State var moodSearch = String()
    
    var body: some View {
        ScrollView {
            Text("Weather App")
                .font(.system(size: 20))
                .padding(.top, 50)
                .padding(.bottom, 50)
            
            Text("\(weatherUrl)")
                .onTapGesture {
                    let url = URL(string: weatherUrl)
                    guard let  DataUrl = url, UIApplication.shared.canOpenURL(DataUrl) else {return}
                    UIApplication.shared.open(DataUrl)
                }
            TextField("Enter Your City Name", text: $searchString)
                .multilineTextAlignment(.center)
                .padding(.bottom, 35)
            
            TextField("Enter your Mood today", text: $moodSearch)
                .multilineTextAlignment(.center)
                .padding(.bottom, 35)
            
            Button("Fetch Data"){fetchAPI()}
                .padding(.all, 5.0)
            
            
            Group {
                Text("You feel \(self.moodSearch) today.")
                    .padding(.bottom, 15)
              
                Text("Temperature:")
                Text("\(data.main.temp)")
                    .padding(.bottom, 15)
                Text("Feels Like:")
                Text("\(data.main.feels_like)")
                    .padding(.bottom, 15)
                Text("Minimum Temperature:")
                Text("\(data.main.temp_min)")
                    .padding(.bottom, 15)
                
              
            }
            Group {
                Text("Maximum Temperature:")
                Text("\(data.main.temp_max)")
                    .padding(.bottom, 15)
                Text("Atmospheric Pressure:")
                Text("\(data.main.pressure)")
                    .padding(.bottom, 15)
                Text("Air Humidity:")
                Text("\(data.main.humidity)")
                    .padding(.bottom, 15)
            }
        }
    }
    
    func fetchAPI() {
        
       
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(self.searchString)&units=imperial&appid=\(apiKey)")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(WeatherData.self, from: data)
                        self.data = decodedData
                    } catch {
                        print("ERROR! SOMETHING WENT WRONG!!!")
                    }
                    if let decodedWeatherData = try? JSONDecoder().decode(WeatherStructure.self, from: data){
                        self.weatherUrl = decodedWeatherData.data[0].url
                    }
                }
            }
        }.resume()
    }
}
struct WeatherStructure: Decodable {
    let data: [dataStructure]
}
struct dataStructure: Decodable {
    let url: String
}

