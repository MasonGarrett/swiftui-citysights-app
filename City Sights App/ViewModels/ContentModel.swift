//
//  ContentModel.swift
//  City Sights App
//
//  Created by Mason Garrett on 2022-01-30.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    override init() {
        
        // init method of NSObject
        super.init()
        
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
        
        // Request permission from user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: Location Manager Delegate Methods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start geolocating the user, after we get permission
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            
            // We don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            
            // We have a location
            // Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            // If we have the coordinates of the user, send into Yelp API
            getBusinesses(category: "restaurants", location: userLocation!)
        }
    }
    
    // MARK: Yelp API Methods
    
    func getBusinesses(category: String, location: CLLocation) {
        
        // Create URL
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            var keys: NSDictionary?

            if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
                    keys = NSDictionary(contentsOfFile: path)
            }
            
            if let dict = keys {
                let clientKey = dict["parseClientKey"] as? String
            
                // Create URL Request
                var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
                request.httpMethod = "GET"
                request.addValue("Bearer \(clientKey!)", forHTTPHeaderField: "Authorization")

                // Get URLSession
                let session = URLSession.shared
                
                // Create Data Task
                let dataTask = session.dataTask(with: request) { (data, response, error) in
                    
                    // Check that there isn't an error
                    if error == nil {
                        print(response)
                    } else {
                        print("error")
                    }
                }
                
                // Start the Data Task
                dataTask.resume()
            }
        }
    }
}
