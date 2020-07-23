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
let currentWeatherURL = "https://api.weatherbit.io/v2.0/current?&lat=\(Location.shareInstance.lat!)&lon=\(Location.shareInstance.long!)&key=19fb7003ac214daca9c83c24419869aa"
 let DailyWeatherURL = "https://api.weatherbit.io/v2.0/forecast/daily?&lat=\(Location.shareInstance.lat!)&lon=\(Location.shareInstance.long!)&key=19fb7003ac214daca9c83c24419869aa"
 let HourlyWeatherURL = "https://api.weatherbit.io/v2.0/forecast/hourly?&lat=\(Location.shareInstance.lat!)&lon=\(Location.shareInstance.long!)&key=19fb7003ac214daca9c83c24419869aa&hours=24"

//These constant are for searchBar
let SBCurrentDataURL = "https://api.weatherbit.io/v2.0/current?&city=\(Location.shareInstance.cityName!.replacingOccurrences(of: " ", with: "%20"))&key=19fb7003ac214daca9c83c24419869aa"
let searchBarForecastURL = "https://api.weatherbit.io/v2.0/forecast/daily?&city=\(Location.shareInstance.cityName!.replacingOccurrences(of: " ", with: "%20"))&key=19fb7003ac214daca9c83c24419869aa"
let searchBarHourlyURL = "https://api.weatherbit.io/v2.0/forecast/hourly?&city=\(Location.shareInstance.cityName!.replacingOccurrences(of: " ", with: "%20"))&key=19fb7003ac214daca9c83c24419869aa&hours=24"

extension Date{
    func dayOfTheWeek() -> String{
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "EEEE, MMM d"
        return dateForamtter.string(from: self)
    }
}
