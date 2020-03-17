//
//  HomeView.swift
//  Weather2
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import SwiftUI

let samples: [Forecast] = [Forecast(icon: Image(systemName: "circle"), dayOfWeek: "Monday", description: "nice weather"), Forecast(icon: Image(systemName: "square"), dayOfWeek: "Tuesday", description: "bad weather")]

struct HomeView: View {
    
    var body: some View {
        VStack {
            SearchView()
            ForecastListView(forecasts: samples)
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
