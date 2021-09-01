//
//  NetworkCall.swift
//  AusWeather
//
//  Created by Talha Ghous on 4/5/21.
//  Copyright © 2021 Talha Ghous. All rights reserved.
//

import UIKit

class NetworkCall: NSObject {
    
    static let sharedInstance = NetworkCall()
    
    static  func getCityData(cityName:String)   {
        
        let url = BaseApi+cityName+"&APPID="+privateApiKey
        let objurl = URL(string: url)
        var city:City? = nil
        
        URLSession.shared.dataTask(with: objurl!) {(data, response, error) in
            
            do {
                
                if data != nil{
                    if  let resultJson:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary{
                        
                        city = City.decodeCity(cityData: resultJson)
                        Singleton.sharedInstance.appendCities(city: city!)
                    }
                }
            } catch {
                print("Error")
            }
            }.resume()
    }// end of getCityData
    
}
