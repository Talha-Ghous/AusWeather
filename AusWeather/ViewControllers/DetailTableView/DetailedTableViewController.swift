//
//  DetailedTableViewController.swift
//  AusWeather
//
//  Created by Talha Ghous on 4/5/21.
//  Copyright © 2021 Talha Ghous. All rights reserved.
//

import UIKit

class DetailedTableViewController: UITableViewController {

    var city:City!
    var modelObject:MODetailed = MODetailed()
    
    
    func setCity(city:City) {
        self.city = city
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.modelObject.city.cityName
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.modelObject.cityArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let objArray = self.modelObject.cityArray[indexPath.row].components(separatedBy: "-")
        cell.textLabel?.text = objArray[0]
        cell.detailTextLabel?.text = objArray[1]
        return cell
    }

}
    // MARK: - Model View Class
class MODetailed: NSObject {
    
    var city:City!
    var cityArray:Array<String>!
    
    override init() {
        self.city = City()
        self.cityArray = Array()
    }
    
    func setCity(city:City) {
        self.city = city
    }
    func cityToArray()  {

        self.cityArray.append("Temperature-"+"\(self.city.temperature! ) ℃")
        self.cityArray.append("High ❆-"+"\(self.city.temperatureMax! ) ℃")
        self.cityArray.append("Low ☀-"+"\(self.city.temperatureMin!) ℃")
        self.cityArray.append("Humidity 💧-"+"\(self.city.humidity!) %")
        let KM = Double(self.city.visibility!)  / 1000.0
        self.cityArray.append("Visibility- "+"\(KM) km")
        self.cityArray.append("Weather Summery-"+self.city.weatherSummery!)
    }
}
