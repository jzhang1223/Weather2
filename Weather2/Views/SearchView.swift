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
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search city here", text: $text)
            Button(action: search) {
                Text("Search")
            }
        }
        .padding(.all)
        .border(Color.black)
    }
}

public func search() {
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
