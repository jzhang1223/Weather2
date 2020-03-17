//
//  ForecastListView.swift
//  Weather2
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import SwiftUI

struct ForecastListView: View {
    
    @State var forecasts: [Forecast]
    
    var body: some View {
//        List {
//            ForecastView()
//            ForecastView()
//        }
        List {
            ForEach(forecasts) { forecast in
                ForecastView(forecast: forecast)
                
            }
        }

    }
}

//struct ForecastListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastListView()
//    }
//}
