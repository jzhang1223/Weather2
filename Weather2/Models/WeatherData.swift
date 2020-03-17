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
let endpoint = "https://api.openweathermap.org"
let cityJSON = "city.list"

class WeatherData: ObservableObject {
    @Published var currentCityData: JSON?
    @Published var currentCity: String?
    
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
        let exampleCall = "\(endpoint)/data/2.5/forecast?id=524901&APPID=\(api_key)"
        let url = "https://api.openweathermap.org/data/2.5/forecast?id=\(cityID)&APPID=\(api_key)"
        
        print("FETCH WEATHER FOR \(cityID)")
        
        // set to url when done
        AF.request(exampleCall, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.currentCityData = json["list"]
                self.currentCity = json["city"]["name"].stringValue
                print("JSON: \(self.currentCityData)")
                //                print("JSON: \(json["list"])")
            //                return json["list"]
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
    
    private func getIdFor(_ cityName: String, json cityData: JSON) -> String {
        for city in cityData.arrayValue {
            if city["name"].string == cityName {
                return city["id"].stringValue
            }
        }
        return "End of filter search"
    }
    
}

