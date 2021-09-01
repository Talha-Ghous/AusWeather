//
//  City.swift
//  AusWeather
//
//  Created by Talha Ghous on 4/5/21.
//  Copyright © 2021 Talha Ghous. All rights reserved.
//

import UIKit

class City: NSObject {
    var cityName:String?
    var temperature:Int?
    var temperatureMin:Int?
    var temperatureMax:Int?
    var humidity:Int?
    var visibility:Int?
    var weatherSummery:String?
    
    
     override init() {}
     init(cityName:String, temperature:Int,temperatureMin:Int, temperatureMax:Int, humidity:Int, visibility:Int, weatherSummery:String ) {
         self.cityName = cityName
         self.temperature = temperature
         self.temperatureMin = temperatureMin
         self.temperatureMax = temperatureMax
         self.humidity = humidity
         self.visibility = visibility
         self.weatherSummery = weatherSummery
        
    }
    
    static func decodeCity(cityData:NSDictionary) -> City {
        let city:City = City()
        
        if let _:AnyObject = cityData.value(forKey: "name") as AnyObject {
            city.cityName = cityData.value(forKey: "name") as? String
        }
        
        if let _:AnyObject = cityData.value(forKey: "main") as AnyObject {
            let main = cityData.value(forKey: "main") as? NSDictionary
            if let temp  =  main?.value(forKey: "temp") as? Double{
                city.temperature = Int(temp) - 273
            }
            if let tempMin = main?.value(forKey: "temp_min") as? Double{
                city.temperatureMin = Int(tempMin) - 273
            }
            if let tempMax = main?.value(forKey: "temp_max") as? Double{
                city.temperatureMax = Int(tempMax) - 273
            }
            city.humidity = main?.value(forKey: "humidity") as? Int
        }
        
        if let _:AnyObject = cityData.value(forKey: "visibility") as AnyObject {
            city.visibility = cityData.value(forKey: "visibility") as? Int
        }
        
        if let _:AnyObject = cityData.value(forKey: "weather") as AnyObject  {
            if  let weatherArray = cityData.value(forKey: "weather") as? Array<NSDictionary>{
                if weatherArray.count > 0 {
                        city.weatherSummery = weatherArray[0].value(forKey: "description") as? String
                }
            }
        }
        return city
    }
    
}
