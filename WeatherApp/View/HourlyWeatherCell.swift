//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Imran Sifat on 8/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var HourlyWeatherImage: UIImageView!
    @IBOutlet weak var HourlyTemp: UILabel!
    var hourlyForecast: HourlyForecast!
    
    func updateHourCell(hourlyForecast: HourlyForecast) {
        //hourlyForecast = HourlyForecast()
        TimeLabel.text = hourlyForecast.hour
        HourlyTemp.text = hourlyForecast.temp
        HourlyWeatherImage.image = UIImage(named: "\(hourlyForecast.weatherType)")
    }
    
}
