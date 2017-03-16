//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 2/15/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var coordinate: Coordinate = {
        let coordinate = Coordinate(latitude: 0, longitude: 0)
        return coordinate
    }()
    
    lazy var locationManager: CLLocationManager = {
        var lm = CLLocationManager()
        lm.requestWhenInUseAuthorization()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        return lm
    }()
    
    
    let client = DarkSkyAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    func displayWeather(using  viewModel: CurrentWeatherViewModel) {
        currentTemperatureLabel.text = viewModel.temperature
        currentHumidityLabel.text = viewModel.humidity
        currentPrecipitationLabel.text = viewModel.precipitationProbability
        currentWeatherIcon.image = viewModel.icon
        currentSummaryLabel.text = viewModel.summary
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refresh() {
        
        toggleRefreshAnimation(on: true)
        
            client.getCurrentWeather(at: coordinate) { [unowned self] (currentWeather, error) in
                
                print(self.coordinate)
                if let currentWeather = currentWeather {
                    let viewModel = CurrentWeatherViewModel(model: currentWeather)
                    self.displayWeather(using: viewModel)
                    self.toggleRefreshAnimation(on: false)
                }
        }
    }
    
    func toggleRefreshAnimation(on: Bool) {
        
        refreshButton.isHidden = on
        on == true ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0] as CLLocation
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
        
        coordinate = Coordinate(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        client.getCurrentWeather(at: coordinate) { [unowned self] (currentWeather, error) in
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherViewModel(model: currentWeather)
                self.displayWeather(using: viewModel)
                self.toggleRefreshAnimation(on: false)
            }
        }
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}





















