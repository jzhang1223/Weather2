//
//  SearchView.swift
//  Weather2
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var data: WeatherData
    @State private var text: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        VStack {
            Rectangle().frame(height: 1)
            HStack (alignment: .center) {
                Image(systemName: "magnifyingglass")
                TextField("Search city here", text: $text)
                Button(action: search) {
                    Text("Search")
                }
                .alert(isPresented: $showError) {
                    Alert(title: Text("Invalid City"), message: Text("No city named \(text). Please search again."), dismissButton: .default(Text("Ok")))
                }
            }
            .padding(.leading)
            .padding(.trailing)
            Rectangle().frame(height: 1)
        }
    }
    
    private func search() {
        dismissKeyboard()
        showError = !data.getWeatherFor(text)
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
