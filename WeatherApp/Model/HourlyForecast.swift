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
    init(hourlyWeatherDict: Dictionary<String, AnyObject>) {
        if let main = hourlyWeatherDict["main"] as? Dictionary<String, AnyObject>{
            if let temp = main["temp"] as? Double{
                self._temp = "\(Int(temp - 273))°"
            }
        }
        if let date = hourlyWeatherDict["dt"] as? Double{
            let unixTimeFormat = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h a"
            dateFormatter.timeStyle = .long
            dateFormatter.dateStyle = .none
            self._hour = unixTimeFormat.HourFormat()
        }
        if let weather = hourlyWeatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main.capitalized
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
