//
//  CurrentWeatherViewModel.swift
//  Stormy
//
//  Created by James Rochabrun on 3/13/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

//3 MVVM MODEL
struct CurrentWeatherViewModel {
    
    let temperature: String
    let humidity: String
    let precipitationProbability: String
    let summary: String
    let icon: UIImage

    init(model: CurrentWeather) {
        
        let roundedTemp = Int(model.temperature)
        self.temperature = "\(roundedTemp)º"
        
        let humidityPercentValue = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentValue)%"
        
        let precipPercentValue = Int(model.precipitationProbability * 100)
        self.precipitationProbability = "\(precipPercentValue)%"
        
        self.summary = model.summary
        
        let weatherIcon = WeatherIcon(iconString: model.iconName)
        self.icon = weatherIcon.image
    }
    
}
