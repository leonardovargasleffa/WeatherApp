//
//  CityTableViewCell.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 11/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var city_name: UILabel!
    @IBOutlet weak var min_max_temp: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCity(_ city: City){
        self.city_name.text = city.name
        self.temp.text = String(format: "%.0fº", city.main.temp.celsius())
        self.min_max_temp.text = String(format: "Min. %.1fº | Máx. %.1fº", city.main.temp_min.celsius(), city.main.temp_max.celsius())
        self.icon.downloaded(from: city.weather.first!.getIconLink())
    }
}
