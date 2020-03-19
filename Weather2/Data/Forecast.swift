//
//  Forecast.swift
//  Weather2
//
//  Created by Guest User on 3/17/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

//import Foundation
import SwiftUI

public struct Forecast: Identifiable {
    public let id = UUID()
    
    var icon: String
    var dayOfWeek: String
    var description: String
}
