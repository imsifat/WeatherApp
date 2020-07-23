//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Imran Sifat on 10/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import UIKit
import Alamofire
class HourlyForecast{
    private var _hour: String!
    private var _temp: String!
    private var _weatherType:String!
    private var _icon:String!
    
    var hour: String{
        if _hour == nil{
            _hour = ""
        }
        return _hour
    }
    var temp: String{
        if _temp == nil{
            _temp = ""
        }
        return _temp
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
    init(hourlyWeatherDict: Dictionary<String, AnyObject>) {
        if let temp = hourlyWeatherDict["temp"] as? Double{
            self._temp = "\(Int(temp))°"
        }
        if let date = hourlyWeatherDict["ts"] as? Double{
            let unixTimeFormat = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h a"
            dateFormatter.timeStyle = .long
            dateFormatter.dateStyle = .none
            self._hour = unixTimeFormat.HourFormat()
        }
        if let weather = hourlyWeatherDict["weather"] as? Dictionary<String, AnyObject>{
            if let description = weather["description"] as? String{
                self._weatherType = description.capitalized
            }
            if let icon = weather["icon"] as? String{
                self._icon = icon
            }
        }
    }
}
extension Date{
    func HourFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: self)
    }
}
