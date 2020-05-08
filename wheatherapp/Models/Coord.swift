//
//  Coord.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper

class Coord: Mappable {
    var lat: Double!
    var lng: Double!
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
    
}
