//
//  LaunchView.swift
//  City Sights App
//
//  Created by Mason Garrett on 2022-01-30.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect the authorization status of geolocating the user
        
        if model.authorizationState == .notDetermined {
            // If undetermined, show onboarding
            OnboardingView()
            
        } else if model.authorizationState == .authorizedWhenInUse || model.authorizationState == .authorizedAlways {
            
            // If approved, show home view
            HomeView()
        } else {
            
            // If denied, show denied view
            LocationDeniedView()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
