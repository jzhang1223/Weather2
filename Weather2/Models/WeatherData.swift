//
//  WeatherData.swift
//  Weather2
//
//  Created by Guest User on 3/17/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

let api_key = "12fde60cfd5214c003ac48e921696d71"
let data_endpoint = "https://api.openweathermap.org"
let cityJSON = "city.list"

class WeatherData: ObservableObject {
    @Published var currentCityData: [CityData] = []
    @Published var currentCity: String?
    // cityName -> cityID
    private var pastIds: [String: String] = [:]
    
    // Returns true for a valid city name
    public func getWeatherFor(_ city: String) -> Bool {
        // check the json file for the city id of the name of the city
        
        if let cityID = getIdFor(city) {
            currentCity = city
            pastIds[city] = cityID
            fetchWeatherFor(cityID: cityID)
            return true
        } else {
            // no id was found
            print("getWeatherFor: NO CITY ID FOUND")
            return false
        }
    }
    
    public func getIdFor(_ city: String) -> String? {
        print("GET ID FOR \"\(city)\"")
        
        if let value = pastIds[city] {
            return pastIds[value]
        }
        
        if let path = Bundle.main.path(forResource: cityJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                return getIdFor(city, FromJSON: jsonObj)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
    
    public func fetchWeatherFor(cityID: String) {
        
        let url = "\(data_endpoint)/data/2.5/forecast?id=\(cityID)&APPID=\(api_key)"
        
        print("FETCH WEATHER FOR \(cityID)")
        let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
        dispatchQueue.async{
            AF.request(url, method: .get).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.setDataWith(json: json)
                    print("JSON: \(self.currentCityData)")
                    print("City: \(self.currentCity)")
                    print(self.pastIds)
                case .failure(let error):
                    print(error)
                }
                
            }
        }
        
    }
    
    private func getIdFor(_ cityName: String, FromJSON cityData: JSON) -> String? {
        for city in cityData.arrayValue {
            if city["name"].string == cityName {
                return city["id"].stringValue
            }
        }
        return nil
    }
    
    private func setDataWith(json: JSON) {
        self.setCityDataWith(json: json["list"].arrayValue)
        self.currentCity = json["city"]["name"].stringValue
        
    }
    
    private func setCityDataWith(json forecasts: [JSON]) {
        self.currentCityData = []
        for forecast in forecasts {
            self.currentCityData.append(CityData(forecast))
        }
    }
    
}

struct CityData: Identifiable {
    public let id = UUID()
    private let dt: Int
    private let weather: Weather
    
    public init(_ json: JSON) {
        self.dt = json["dt"].intValue
        self.weather = Weather(json["weather"].arrayValue)
    }
    
    public func getDayOfWeek() -> String {
        let forecastDate = Date(timeIntervalSince1970: TimeInterval(self.dt))
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        return dayOfWeekFormatter.string(from: forecastDate)
    }
    
    public func getWeatherDescription() -> String {
        return self.weather.description
    }
    
    public func getIcon() -> String {
        return self.weather.icon
    }
}

struct Weather {
    let description: String
    let icon: String
    
    public init(_ weatherList: [JSON]) {
        if !weatherList.isEmpty {
            self.description = weatherList[0]["description"].stringValue
            self.icon = weatherList[0]["icon"].stringValue
        } else {
            self.description = "No description"
            self.icon = "No icon name"
        }
    }
}
