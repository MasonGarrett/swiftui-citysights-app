//
//  BusinessSection.swift
//  City Sights App
//
//  Created by Mason Garrett on 2022-01-30.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var businesses: [Business]
    
    var body: some View {
        
        Section (header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                Text(business.name ?? "")
                Divider()
            }
        }
    }
}

