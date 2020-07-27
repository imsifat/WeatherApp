//
//  Constant.swift
//  WeatherApp
//
//  Created by Imran Sifat on 9/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()
let apiKEY = "19fb7003ac214daca9c83c24419869aa"
let currentWeatherURL = "https://api.weatherbit.io/v2.0/current?&lat=\(lat!)&lon=\(long!)&key=19fb7003ac214daca9c83c24419869aa"
 let DailyWeatherURL = "https://api.weatherbit.io/v2.0/forecast/daily?&lat=\(lat!)&lon=\(long!)&key=19fb7003ac214daca9c83c24419869aa"
 let HourlyWeatherURL = "https://api.weatherbit.io/v2.0/forecast/hourly?&lat=\(lat!)&lon=\(long!)&key=19fb7003ac214daca9c83c24419869aa&hours=24"


extension Date{
    func dayOfTheWeek() -> String{
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "EEEE, MMM d"
        return dateForamtter.string(from: self)
    }
}
