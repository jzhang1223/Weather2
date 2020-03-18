//
//  HomeView.swift
//  Weather2
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var data: WeatherData
    
    var body: some View {
        NavigationView {
            VStack {
                SearchView()
                ForecastListView()
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
