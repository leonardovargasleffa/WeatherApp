//
//  Request.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper

class Request: Mappable {
    var message: String!
    var cod: String!
    var count: Int!
    var list: [City]!
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        message <- map["message"]
        cod <- map["cod"]
        count <- map["count"]
        list <- map["list"]
    }
}
