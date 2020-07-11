//
//  Forecast.swift
//  WeatherApp
//
//  Created by Imran Sifat on 9/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class Forecast{
    private var _maxTemp: String!
    private var _minTemp: String!
    private var _date: String!
    private var _weatherType:String!
    
    var maxTemp:String{
        if _maxTemp == nil{
            _maxTemp = ""
        }
        return _maxTemp
    }
    var minTemp:String{
        if _minTemp == nil {
            _minTemp = ""
        }
        return _minTemp
    }
    var date:String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    var weatherType:String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    init(weatherDict: Dictionary<String, AnyObject> ) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
            if let min = temp["min"] as? Double{
                self._minTemp = "\(Int(min - 273.15))°"
                print(self._minTemp!)
            }
            if let max = temp["max"] as? Double{
                self._maxTemp = "\(Int(max - 273.15))°"
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
        if let date = weatherDict["dt"] as? Double{
            let unixDateFormat = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            self._date = unixDateFormat.dayOfTheWeek()
        }
        
    }
}

