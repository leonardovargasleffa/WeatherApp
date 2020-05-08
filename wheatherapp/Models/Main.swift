//
//  Main.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper

class Main: Mappable {
    
    var temp: Float!
    var pressure: Int!
    var humidity: Int!
    var temp_min: Float!
    var temp_max: Float!
        
    required init?(map: Map){}
    
    func mapping(map: Map) {
        temp <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
    }
    
}
