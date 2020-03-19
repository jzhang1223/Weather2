//
//  Weather2Tests.swift
//  Weather2Tests
//
//  Created by Guest User on 3/16/20.
//  Copyright © 2020 Justin Zhang. All rights reserved.
//

import XCTest
@testable import Weather2

class Weather2Tests: XCTestCase {

    let weatherData = WeatherData()
    
    override func setUp() {

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetIdForCityname() {
        XCTAssertEqual(weatherData.getIdFor("Boston"), "1723862")
        XCTAssertEqual(weatherData.getIdFor("Taglag"), "3245")
        XCTAssertEqual(weatherData.getIdFor("Tampa"), "4174757")
    }

}
