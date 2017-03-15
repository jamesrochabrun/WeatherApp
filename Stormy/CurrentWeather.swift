//
//  CurrentWeather.swift
//  Stormy
//
//  Created by James Rochabrun on 3/13/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation


//2 MODEL FOR THE CURRENT WEATHER RESPONSE
struct CurrentWeather {
    let temperature: Double
    let humidity: Double
    let precipitationProbability: Double
    let summary: String
    let iconName: String
}


//initializers written in an extension of a struct do not override the member wise initializers so we can just have an altarnetively initializer that takes a josn object
extension CurrentWeather {
    
    struct Key  {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let precipitationProbability = "precipProbability"
        static let summary = "summary"
        static let icon = "icon"
    }
    
    init?(json: [String: AnyObject]) {
        
        guard let tempValue = json[Key.temperature] as? Double,
        let humidityValue = json[Key.humidity] as? Double,
        let precipitationProbabilityValue = json[Key.precipitationProbability] as? Double,
        let summaryString = json[Key.summary] as? String,
            let iconString = json[Key.icon] as? String else { return nil }
        
        self.temperature = tempValue
        self.humidity = humidityValue
        self.precipitationProbability = precipitationProbabilityValue
        self.summary = summaryString
        self.iconName = iconString
    }
}










