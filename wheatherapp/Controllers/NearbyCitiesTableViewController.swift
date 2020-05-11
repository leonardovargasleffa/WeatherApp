//
//  NearbyCitiesTableViewController.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 11/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit

class NearbyCitiesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WebService.sharedInstance.nearbyCities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cell.setCity(WebService.sharedInstance.nearbyCities[indexPath.row])
        return cell
    }

}
