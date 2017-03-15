//
//  DarkSkyAPIClient.swift
//  Stormy
//
//  Created by James Rochabrun on 3/14/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

//5 API
class DarkSkyAPIClient {
    
    fileprivate let darkSkyApiKey = "a366117fb4934808c12ee4e2b89daeab"
    
    lazy var baseURL: URL = {
        let base = URL(string: "https://api.darksky.net/forecast/\(self.darkSkyApiKey)/")!
        return base
    }()
    
    let downloader = JSONDownloader()
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, DarkSkyError?) -> ()
    
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping  CurrentWeatherCompletionHandler) {
        
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else {
            completion(nil, .invalidURL)
            return
        }
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (json, error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                guard let currentWeatehrJSON = json["currently"] as? [String: AnyObject], let currentWeather = CurrentWeather(json: currentWeatehrJSON) else {
                    completion(nil, .jsonParsingFailure)
                    return
                }
                completion(currentWeather, nil)
            }
       }
        task.resume()
    }
}




