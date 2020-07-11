//
//  CourrentWeather.swift
//  WeatherApp
//
//  Created by Imran Sifat on 9/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import UIKit
import Alamofire
class CurrentWeather{
    private var _date: String!
    private var _currentTemp: String!
    private var _location: String!
    private var _weatherType: String!
    
    var date:String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    var currentTemp:String{
        if _currentTemp == nil{
            _currentTemp = ""
        }
        return _currentTemp
    }
    var location:String{
        if _location == nil{
            _location = ""
        }
        return _location
    }
    var weatherType:String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    
}

