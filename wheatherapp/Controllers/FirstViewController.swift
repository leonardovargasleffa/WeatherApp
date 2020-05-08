//
//  FirstViewController.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: CustomViewController, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var city_name: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var min_max_temp: UILabel!
    
    func getLocation(){
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
            
        } else {
            WSReturn.locationError.message.errorAlert(self)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
         let locationObj = locationArray.lastObject as! CLLocation
         let coord = locationObj.coordinate
        
         if(WebService.sharedInstance.weatherData == nil){
            locationManager.stopUpdatingLocation()
             self.showLoading()
             WebService.sharedInstance.getWeatherData(coord.latitude, coord.longitude).subscribe(onError: { [weak self] (error) in
                 self!.stopLoading();
                WSReturn.error.message.errorAlert(self!)
                
            }, onCompleted: { [weak self] in
                self!.stopLoading()
                self!.setWeatherData(WebService.sharedInstance.currentCity);
                
            }).disposed(by: self.disposeBag)
         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLocation();
    }
    
    func setWeatherData(_ city: City){
        self.city_name.text = city.name
        self.temp.text = String(format: "%.2fº", city.main.temp.celsius())
        self.min_max_temp.text = String(format: "Min. %.2fº | Máx. %.2fº", city.main.temp_min.celsius(), city.main.temp_max.celsius())
        self.icon.downloaded(from: city.weather.first!.getIconLink())
    }
}

