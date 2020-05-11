//
//  WebService.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON

class WebService: NSObject {
    static let sharedInstance = WebService()
    
    var currentCity: City!
    var nearbyCities: [City]!
    
    func getWeatherData(_ lat: Double, _ lng: Double) -> Observable<Request> {
        return Observable<Request>.create { observer -> Disposable in
            let api_url = Bundle.main.object(forInfoDictionaryKey: "URL_WEATHERAPI") as! String
            let api_key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
            
            Alamofire.request("\(api_url)find/?lat=\(lat)&lon=\(lng)&lang=en&cnt=21&appid=\(api_key)", method: .get).responseObject { (response: DataResponse<Request>) in
                    guard let request = response.result.value else {
                        observer.on(.error(WSReturn.error))
                        return
                    }
                    
                    if(Int(request.cod) != WSReturn.success.code || request.list.count == 0){
                        observer.on(.error(WSReturn.error))
                        return
                    }
                
                    WebService.sharedInstance.currentCity = request.list.first!
                    WebService.sharedInstance.nearbyCities = request.list.dropFirst().sorted(by: { $0.main.temp > $1.main.temp });
                    observer.on(.completed)
            }
            
            return Disposables.create()
            
        }
    }
    
}
