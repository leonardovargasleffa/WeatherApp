//
//  City.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper

class City: Mappable {
    var id: Int!
    var cod: Int!
    var name: String!
    var coord: Coord!
    var main: Main!
    var weather: [Weather]!
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        cod <- map["cod"]
        
        name <- map["name"]
        coord <- map["coord"]
        main <- map["main"]
        weather <- map["weather"]
    }
    
}
