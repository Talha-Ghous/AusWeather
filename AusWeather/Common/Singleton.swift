//
//  Singleton.swift
//  AusWeather
//
//  Created by Talha Ghous on 4/5/21.
//  Copyright © 2021 Talha Ghous. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    // MARK: - properties
    static let sharedInstance = Singleton()
    var cities:Array<City>? = nil
    var delegate:NetworkProtocol?
    
    // MARK: - Functions
    private override init() {
        super.init()
        
    }// init ends
    
    // geting data for three cities to start up
    func startUpCities()  {
        self.cities = Array()
        NetworkCall.getCityData(cityName: "Sydney")
        NetworkCall.getCityData(cityName: "Melbourne")
        NetworkCall.getCityData(cityName: "Brisbane")
    }
    
    func appendCities(city:City)   {
        self.cities?.append(city)
        self.delegate?.cityAdded!()
    }
    
}// class ends


@objc protocol NetworkProtocol{
    @objc optional func cityAdded()
    
}
