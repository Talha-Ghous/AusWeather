//
//  MainTableViewController.swift
//  AusWeather
//
//  Created by Talha Ghous on 4/5/21.
//  Copyright © 2021 Talha Ghous. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, NetworkProtocol {

    var modelObject:MainModelClass!
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modelObject = MainModelClass()
        modelObject.sharedInstance.delegate = self
        modelObject.sharedInstance.startUpCities()
        
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.blue
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = modelObject.sharedInstance.cities?.count {
            return count
        }else{
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = modelObject.sharedInstance.cities![indexPath.row].cityName
        let temp =   modelObject.sharedInstance.cities![indexPath.row].temperature
        cell.detailTextLabel?.text = "\(temp!) ℃"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailedTableViewController") as! DetailedTableViewController
        myVC.modelObject.setCity(city:modelObject.sharedInstance.cities![indexPath.row])
        myVC.modelObject.cityToArray()
        self.navigationController?.pushViewController(myVC, animated: true)
    }
 
    // MARK: - IBActions functions
    @IBAction func AddCityTriggered(_ sender: UIBarButtonItem) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "AddCityTableViewController") as! AddCityTableViewController
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
    // MARK: - Protocole functions
    func cityAdded()  {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
        
    }

}


class MainModelClass: NSObject {
    
    var sharedInstance = Singleton.sharedInstance
    
    
}
