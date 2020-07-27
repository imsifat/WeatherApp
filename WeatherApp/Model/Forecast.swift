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
    private var _icon:String!
    
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
    var icon:String{
        if _icon == nil{
            _icon = ""
        }
        return _icon
    }
    init(weatherDict: Dictionary<String, AnyObject> ) {
        if let low_temp = weatherDict["low_temp"] as? Double{
            self._minTemp = "\(Int(low_temp))°"
        }
        if let max_temp = weatherDict["max_temp"] as? Double{
            self._maxTemp = "\(Int(max_temp))°"
        }
        if let weather = weatherDict["weather"] as? Dictionary<String, AnyObject>{
            if let description = weather["description"] as? String{
                self._weatherType = description.capitalized
            }
            if let icon = weather["icon"] as? String{
                self._icon = icon
            }
        }
        if let date = weatherDict["ts"] as? Double{
            let unixDateFormat = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            self._date = unixDateFormat.dayOfTheWeek()
        }
        
    }
}

