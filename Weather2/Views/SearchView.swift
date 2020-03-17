//
//  SearchView.swift
//  Weather2
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State var text: String = ""
    @EnvironmentObject var data: WeatherData
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search city here", text: $text)
            Button(action: search) {
                Text("Search")
            }
            .onTapGesture {
                
            }
        }
        .padding(.all)
        .border(Color.black)
    }
    
    private func search() {
        print(data.getWeatherFor(text))
        dismissKeyboard()
    }
}

private extension View {
    func dismissKeyboard() {
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.endEditing(true)
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
