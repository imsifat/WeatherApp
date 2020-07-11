//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Imran Sifat on 8/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
typealias protocols = UITableViewDelegate & UITableViewDataSource & UICollectionViewDelegate & UICollectionViewDataSource & UISearchBarDelegate & CLLocationManagerDelegate
class WeatherVC: UIViewController, protocols {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var DateLBL: UILabel!
    @IBOutlet weak var CurrentTemp: UILabel!
    @IBOutlet weak var LocationName: UILabel!
    @IBOutlet weak var WeatherImage: UIImageView!
    @IBOutlet weak var WeatherType: UILabel!
    
    var currentWeather:CurrentWeather!
    var dailyWeather = [Forecast]()
    var hourlyWeather = [HourlyForecast]()
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuth()
    }
    func locationAuth(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.shareInstance.lat = currentLocation.coordinate.latitude
            Location.shareInstance.long = currentLocation.coordinate.longitude
            DownloadCurrentWeatherData()
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuth()
        }
    }
    func DownloadCurrentWeatherData(){
        weatherDate()
        DownloadHourlyWeatherData()
        DownloadDailyWeatherData()
        AF.request(currentWeatherURL).responseJSON{response in
            if let dict = response.value as? Dictionary<String, AnyObject>{
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    if let temp = main["temp"] as? Double{
                        self.CurrentTemp.text = "\(Int(temp - 273.15))°C"
                    }
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self.WeatherType.text = main.capitalized
                        self.WeatherImage.image = UIImage(named: main)
                    }
                }
                if let name = dict["name"] as? String{
                    self.LocationName.text = name.capitalized
                }
            }
        }
    }
    func DownloadDailyWeatherData(){
        AF.request(DailyWeatherURL).responseJSON{response in
            if let dict = response.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    for obj in list{
                        let forecast = Forecast(weatherDict: obj)
                        self.dailyWeather.append(forecast)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    func DownloadHourlyWeatherData(){
        AF.request(HourlyWeatherURL).responseJSON{response in
            if let dict = response.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    for obj in list{
                        let hourlyForecast = HourlyForecast(hourlyWeatherDict: obj)
                        self.hourlyWeather.append(hourlyForecast)                     
                    }
                    
                    self.collectionView.reloadData()
                }
            }
        }
    }
    func weatherDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self.DateLBL.text = "Today, \(currentDate)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell") as? DailyWeatherCell{
            let forecast = dailyWeather[indexPath.row]
            cell.updateCell(forecast: forecast)
            
            return cell
        }else {
            return UITableViewCell()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCell", for: indexPath) as? HourlyWeatherCell{
            let hourlyForecast = hourlyWeather[indexPath.row]
            cell.updateHourCell(hourlyForecast: hourlyForecast)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeather.count
    }
}
