//
//  Weather.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper

class Weather: Mappable {
    var id: Int!
    var main: String!
    var description: String!
    var icon: String!
        
    required init?(map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
    
    func getIconLink() -> String {
        let image_url = Bundle.main.object(forInfoDictionaryKey: "IMAGE_LINK") as! String
        return String(format: image_url, self.icon!);
    }
    
}
