//
//  ForecastListView.swift
//  Weather2
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import SwiftUI

struct ForecastListView: View {
    
//    @State var forecasts: [Forecast]
    @EnvironmentObject var data: WeatherData
    
    var body: some View {
        List {
//            ForEach(data.currentCityData) { cityData in
//                ForecastView(forecast: Forecast(icon: cityData.getIcon(),
//                                                dayOfWeek: cityData.getDT(),
//                                                description: cityData.getWeatherDescription()))
//            }
            
            ForEach(data.currentCityData) { cityData in
                ForecastView(forecast: cityData)
            }
        }

    }
}

//struct ForecastListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastListView()
//    }
//}
