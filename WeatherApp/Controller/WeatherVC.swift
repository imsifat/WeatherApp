//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Imran Sifat on 8/7/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
typealias protocols = UITableViewDelegate & UITableViewDataSource & UICollectionViewDelegate & UICollectionViewDataSource & UISearchBarDelegate & CLLocationManagerDelegate
class WeatherVC: UIViewController, protocols {
    //IBoutlets
    @IBOutlet weak var CLLocationBTN: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherSearchBar: UISearchBar!
    @IBOutlet weak var DateLBL: UILabel!
    @IBOutlet weak var CurrentTemp: UILabel!
    @IBOutlet weak var LocationName: UILabel!
    @IBOutlet weak var WeatherImage: UIImageView!
    @IBOutlet weak var WeatherType: UILabel!
    
    //variables
    var inSearchMode = false
    var currentWeather:CurrentWeather!
    var dailyWeather = [Forecast]()
    var SBdailyWeather = [Forecast]()
    var SBhourlyWeather = [HourlyForecast]()
    var hourlyWeather = [HourlyForecast]()
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    var cityNames = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CLLocationBTN.layer.cornerRadius = 13.0
        weatherSearchBar.delegate = self
        weatherSearchBar.returnKeyType = UIReturnKeyType.done
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
            lat = currentLocation.coordinate.latitude
            long = currentLocation.coordinate.longitude
            DownloadCurrentWeatherData()
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuth()
        }
    }
    
    //These function are for search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if inSearchMode == false{
            inSearchMode = true
            cityNames = weatherSearchBar.text!.lowercased()
            downloadCurrentWeatherDataForSB()
            view.endEditing(true)
        }else {
            inSearchMode = false
            cityNames = ""
            locationAuth()
            tableView.reloadData()
            collectionView.reloadData()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    //these function are for downloading weather data
    func DownloadCurrentWeatherData(){
        weatherDate()
        DownloadHourlyWeatherData()
        DownloadDailyWeatherData()
        AF.request(currentWeatherURL).responseJSON{response in
            if let dict = response.value as? Dictionary<String, AnyObject>{
                if let data = dict["data"] as? [Dictionary<String, AnyObject>]{
                    if let temp = data[0]["temp"] as? Double{
                        self.CurrentTemp.text = "\(Int(temp))°C"
                    }
                    if let weather = data[0]["weather"] as? Dictionary<String, AnyObject>{
                        if let description = weather["description"] as? String{
                            self.WeatherType.text = description.capitalized
                        }
                        if let icon = weather["icon"] as? String{
                            self.WeatherImage.image = UIImage(named: icon)
                        }
                    }
                    if let name = data[0]["city_name"] as? String{
                        self.LocationName.text = name.capitalized
                    }
                }
            }
        }
    }
    func DownloadDailyWeatherData(){
        AF.request(DailyWeatherURL).responseJSON{response in
            if let dict = response.value as? Dictionary<String, AnyObject>{
                if let data = dict["data"] as? [Dictionary<String, AnyObject>]{
                    for obj in data{
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
                if let data = dict["data"] as? [Dictionary<String, AnyObject>]{
                    for obj in data{
                        let hourlyForecast = HourlyForecast(hourlyWeatherDict: obj)
                        self.hourlyWeather.append(hourlyForecast)                     
                    }
                    
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func getUrl(cityName: String) -> String{
        let url = "https://api.weatherbit.io/v2.0/current?&city=\(cityName ))&key=19fb7003ac214daca9c83c24419869aa"
        return url
    }
    
    //these function are for downloading weather data for search bar
    func downloadCurrentWeatherDataForSB(){
        weatherDate()
        downloadForecastForSearchBar()
        downloadHourlyForSearchBar()
        let url = "https://api.weatherbit.io/v2.0/current?&city=\(cityNames.replacingOccurrences(of: " ", with: "%20") ))&key=19fb7003ac214daca9c83c24419869aa"
        print(url)
        AF.request(url).responseJSON{response in
            if let dict = response.value as? Dictionary<String, AnyObject>{
                if let data = dict["data"] as? [Dictionary<String, AnyObject>]{
                    if let temp = data[0]["temp"] as? Double{
                        self.CurrentTemp.text = "\(Int(temp))°C"
                    }
                    if let weather = data[0]["weather"] as? Dictionary<String, AnyObject>{
                        if let description = weather["description"] as? String{
                            self.WeatherType.text = description.capitalized
                        }
                        if let icon = weather["icon"] as? String{
                            self.WeatherImage.image = UIImage(named: icon)
                        }
                    }
                    if let name = data[0]["city_name"] as? String{
                        self.LocationName.text = name.capitalized
                    }
                }
            }
        }
    }
    func downloadForecastForSearchBar(){
        let searchBarForecastURL = "https://api.weatherbit.io/v2.0/forecast/daily?&city=\(cityNames.replacingOccurrences(of: " ", with: "%20"))&key=19fb7003ac214daca9c83c24419869aa"
        print(searchBarForecastURL)
        AF.request(searchBarForecastURL).responseJSON{response in
            if let dict = response.value as? Dictionary<String, AnyObject>{
                if let data = dict["data"] as? [Dictionary<String, AnyObject>]{
                    for obj in data{
                        let forecast = Forecast(weatherDict: obj)
                        self.SBdailyWeather.append(forecast)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    func downloadHourlyForSearchBar(){
        let searchBarHourlyURL = "https://api.weatherbit.io/v2.0/forecast/hourly?&city=\(cityNames.replacingOccurrences(of: " ", with: "%20"))&key=19fb7003ac214daca9c83c24419869aa&hours=24"
        print(searchBarHourlyURL)
        AF.request(searchBarHourlyURL).responseJSON{response in
            if let dict = response.value as? Dictionary<String, AnyObject>{
                if let data = dict["data"] as? [Dictionary<String, AnyObject>]{
                    for obj in data{
                        let hourlyForecast = HourlyForecast(hourlyWeatherDict: obj)
                        self.SBhourlyWeather.append(hourlyForecast)
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
    
    //these function are for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell") as? DailyWeatherCell{
            if inSearchMode == true{
                let forecast = SBdailyWeather[indexPath.row]
                cell.updateCell(forecast: forecast)
            }else{
                inSearchMode = false
                let forecast = dailyWeather[indexPath.row]
                cell.updateCell(forecast: forecast)
            }
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    //these are for collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCell", for: indexPath) as? HourlyWeatherCell{
            if inSearchMode == true{
                let hourlyForecast = SBhourlyWeather[indexPath.row]
                cell.updateHourCell(hourlyForecast: hourlyForecast)
            }else{
                inSearchMode = false
                let hourlyForecast = hourlyWeather[indexPath.row]
                cell.updateHourCell(hourlyForecast: hourlyForecast)
            }
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeather.count
    }
    @IBAction func CLWeather(_ sender: UIButton) {
        locationAuth()
        inSearchMode = false
        cityNames = ""
        weatherSearchBar.text = "";
    }
    
    
    
}
