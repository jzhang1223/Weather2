//
//  ForecastView.swift
//  Weather2
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ForecastView: View {
    
    @State var forecast: CityData
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                WebImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.getIcon())@2x.png"))
                Text("\(forecast.getDayOfWeek())")
            }
            Text(forecast.getWeatherDescription())
            
        }
    }
}

//struct ForecastView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastView(forecast: Forecast(id: <#ObjectIdentifier#>, icon: Image(systemName: "circle"),
//                              dayOfWeek: "Monday", description: "Description long long long long long long long long long long long long long long long long long"))
//    }
//}
