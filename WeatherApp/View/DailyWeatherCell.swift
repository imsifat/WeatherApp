//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by Imran Sifat on 8/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import UIKit
import Alamofire

class DailyWeatherCell: UITableViewCell {
    @IBOutlet weak var DayOfTheWeak: UILabel!
    @IBOutlet weak var DailyWeatherType: UILabel!
    @IBOutlet weak var DailyWeatherImage: UIImageView!
    @IBOutlet weak var MaxTemp: UILabel!
    @IBOutlet weak var MinTemp: UILabel!
    var forecast:Forecast!
    
    func updateCell(forecast: Forecast){
        DayOfTheWeak.text = forecast.date
        DailyWeatherType.text = forecast.weatherType
        DailyWeatherImage.image = UIImage(named: "\(forecast.weatherType)")
        MaxTemp.text = forecast.maxTemp
        MinTemp.text = forecast.minTemp
    }
    
}
