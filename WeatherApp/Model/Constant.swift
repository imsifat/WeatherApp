//
//  Constant.swift
//  WeatherApp
//
//  Created by Imran Sifat on 9/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()
let currentWeatherURL = "https://samples.openweathermap.org/data/2.5/weather?lat=\(Location.shareInstance.lat!)&lon=\(Location.shareInstance.long!)&appid=439d4b804bc8187953eb36d2a8c26a02"
 let DailyWeatherURL = "https://samples.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.shareInstance.lat!)&lon=\(Location.shareInstance.long!)&cnt=10&appid=b1b15e88fa797225412429c1c50c122a1"
 let HourlyWeatherURL = "https://samples.openweathermap.org/data/2.5/forecast/hourly?lat=\(Location.shareInstance.lat!)&lon=\(Location.shareInstance.long!)&appid=439d4b804bc8187953eb36d2a8c26a02"

extension Date{
    func dayOfTheWeek() -> String{
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "EEEE"
        return dateForamtter.string(from: self)
    }
}
