//
//  AddCityTableViewController.swift
//  AusWeather
//
//  Created by Talha Ghous on 5/5/21.
//  Copyright © 2021 Talha Ghous. All rights reserved.
//

import UIKit

class AddCityTableViewController: UITableViewController , UISearchBarDelegate{

    // MARK: - Properties
    var moAddCity:MOAddCity = MOAddCity()
    var searchedCities = Array<String>()
    var searching = false
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add City"
        

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searching {
            return self.searchedCities.count
        }else{
            return self.moAddCity.cities.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if searching {
            cell.textLabel?.text = self.searchedCities[indexPath.row]
        }else{
            cell.textLabel?.text = self.moAddCity.cities[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if searching {
            NetworkCall.getCityData(cityName: self.searchedCities[indexPath.row])
        }else{
            NetworkCall.getCityData(cityName: self.moAddCity.cities[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }
 
    // MARK: - UISearchBar Functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCities = self.moAddCity.cities.filter { $0.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

// MARK: - Model View Class
class MOAddCity: NSObject {
    
    var cities:Array<String>!
    override init() {
        super.init()
        self.cities = Array()
        self.readFile()
    }
    
    func readFile()  {
        
        if let path = Bundle.main.path(forResource: "cityList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
               // let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if  let resultJson:NSArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray{
                    
                    for dic in resultJson {
                        if let obj = dic as? NSDictionary{
                            self.cities.append(obj.value(forKey: "name") as! String)
                        }
                    }
                }
            } catch {
                // handle error
            }
        }
    }
}
