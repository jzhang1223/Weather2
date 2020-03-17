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
//import CityData

let api_key = "12fde60cfd5214c003ac48e921696d71"
let endpoint = "https://api.openweathermap.org"
let cityJSON = "city.list"

class WeatherData: ObservableObject {
    @Published var currentCityData: [CityData] = []
    @Published var currentCity: String?
//    @Published var forecasts: [Forecast]?
    
    public func getWeatherFor(_ city: String) {
        // first check if it's stored already
        
        // check the json file for the city id of the name of the city
        if let cityID = getIdFor(city) {
            currentCity = city
            fetchWeatherFor(cityID: cityID)
        } else {
            // no id was found
            print("getWeatherFor: NO CITY ID FOUND")
        }
        
        // make call for data
        
    }
    
    public func getIdFor(_ city: String) -> String? {
        print("GET ID FOR \"\(city)\"")
        if let path = Bundle.main.path(forResource: cityJSON, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                //                let filteredJSON = getIDFrom(jsonObj)
                return getIdFor(city, json: jsonObj)
                //                print("jsonData:\(jsonObj)")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
    
    public func fetchWeatherFor(cityID: String) {
        // Moscow
//        let exampleCall = "\(endpoint)/data/2.5/forecast?id=524901&APPID=\(api_key)"
        let url = "\(endpoint)/data/2.5/forecast?id=\(cityID)&APPID=\(api_key)"
        
        print("FETCH WEATHER FOR \(cityID)")
        
        // set to url when done
        AF.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                self.currentCityData = [CityData(json["list"].arrayValue)]
                self.setCityDataWith(json: json["list"].arrayValue)
                self.currentCity = json["city"]["name"].stringValue
                print("JSON: \(self.currentCityData)")
                print("City: \(self.currentCity)")
            case .failure(let error):
                print(error)
                //                return []
            }
            
        }
        
    }
    
    //    public func getIconFor(iconCode: String) -> String {
    //        let url = "http://openweathermap.org/img/wn/\(iconCode)@2x.png"
    //        //get the image
    //    }
    
    private func getIdFor(_ cityName: String, json cityData: JSON) -> String? {
        for city in cityData.arrayValue {
            if city["name"].string == cityName {
                return city["id"].stringValue
            }
        }
        return nil
    }
    
    private func setCityDataWith(json forecasts: [JSON]) {
        for forecast in forecasts {
            self.currentCityData.append(CityData(forecast))
        }
    }
    
}

struct CityData: Identifiable {
    public let id = UUID()
    let dt: Int
    let weather: Weather
    
    public init(_ json: JSON) {
        self.dt = json["dt"].intValue
        self.weather = Weather(json["weather"].arrayValue)
    }
    
    public func getDT() -> Int {
        return self.dt
    }
    
    public func getWeatherDescription() -> String {
        return self.weather.description
    }
    
    public func getIcon() -> String {
        return self.weather.icon
    }
}

struct Weather: Decodable {
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
