//
//  BusinessMap.swift
//  City Sights App
//
//  Created by Mason Garrett on 2022-02-06.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    var locations: [MKPointAnnotation] {
        
        var annotations = [MKPointAnnotation]()
        
        // Create a set of annotations from our list of businesses
        for bussiness in model.restaurants + model.sights {
            
            // If the business has a lat/long, create an MKPointAnnotation for it
            if let lat = bussiness.coordinates?.latitude, let long = bussiness.coordinates?.longitude {
                
                // Create a new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = bussiness.name ?? ""
                
                annotations.append(a)
            }
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        // Make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
 
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones based on the business
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
    }
}
