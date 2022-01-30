//
//  CitySightsApp.swift
//  City Sights App
//
//  Created by Mason Garrett on 2022-01-30.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
