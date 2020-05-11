//
//  MyCityViewController.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON
import MBProgressHUD

class MyCityViewController: UIViewController, CLLocationManagerDelegate {
    
    let disposeBag = DisposeBag()
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var city_name: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var min_max_temp: UILabel!
    
    func showLoading(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func stopLoading(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func getLocation(){
       locationManager.delegate = self
       locationManager.distanceFilter = kCLDistanceFilterNone
       locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
       locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
            
        } else {
            WSReturn.locationError.message.errorAlert(self)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        WSReturn.locationError.message.errorAlert(self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
         let locationObj = locationArray.lastObject as! CLLocation
         let coord = locationObj.coordinate
        
         if(WebService.sharedInstance.currentCity == nil){
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
        self.temp.text = String(format: "%.0fº", city.main.temp.celsius())
        self.min_max_temp.text = String(format: "Min. %.1fº | Máx. %.1fº", city.main.temp_min.celsius(), city.main.temp_max.celsius())
        self.icon.downloaded(from: city.weather.first!.getIconLink())
    }
}

extension Float {
    func celsius() -> Float {
        return (self - 273.15);
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension String {
    func errorAlert(_ controller: UIViewController) {
        let alert = UIAlertController(title: "Ops!", message: self, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
