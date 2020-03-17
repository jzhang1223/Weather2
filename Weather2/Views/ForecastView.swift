//
//  ForecastView.swift
//  Weather2
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import SwiftUI

struct ForecastView: View {
    
    @State var forecast: Forecast
    
    var body: some View {
        VStack {
            HStack {
//                Image(systemName: "circle")
                forecast.icon
//                Text("Title")
                Text(forecast.dayOfWeek)
            }
//            Text("Description long long long long long long long long long long long long long long long long long")
            Text(forecast.description)
            
        }
    }
}

//struct ForecastView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastView(forecast: Forecast(id: <#ObjectIdentifier#>, icon: Image(systemName: "circle"),
//                              dayOfWeek: "Monday", description: "Description long long long long long long long long long long long long long long long long long"))
//    }
//}
