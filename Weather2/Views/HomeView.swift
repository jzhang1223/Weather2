//
//  HomeView.swift
//  Weather2
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import SwiftUI

//let samples: [Forecast] = [Forecast(icon: Image(systemName: "circle"), dayOfWeek: "Monday", description: "nice weather"), Forecast(icon: Image(systemName: "square"), dayOfWeek: "Tuesday", description: "bad weather")]

struct HomeView: View {
    
    @EnvironmentObject var data: WeatherData
    
    var body: some View {
        NavigationView {
            VStack {
                SearchView()
                ForecastListView()
//                ForecastListView(forecasts: allData)
            }
            .navigationBarTitle(data.currentCity == nil ? "Weather" : "Weather for \(data.currentCity!)")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
