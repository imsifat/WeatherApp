//
//  Location.swift
//  WeatherApp
//
//  Created by Imran Sifat on 10/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import CoreLocation
class Location{
    static var shareInstance = Location()
    init(){}
    var lat:Double!
    var long:Double!
    var cityName:String!
}
