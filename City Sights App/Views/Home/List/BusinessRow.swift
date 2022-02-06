//
//  BusinessRow.swift
//  City Sights App
//
//  Created by Mason Garrett on 2022-02-02.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business: Business
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            HStack {
                
                // Image
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                
                // Name and Distance
                VStack (alignment: .leading) {
                    
                    Text(business.name ?? "")
                        .bold()
                    
                    Text(String(format: "%.1f km away", (business.distance ?? 0) / 1000))
                        .font(.caption)
                }
                
                Spacer()
                
                // Star rating and number of reviews
                VStack (alignment: .leading) {
                    
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            DashedDivider()
                .padding(.vertical)
        }
        .foregroundColor(.black)
    }
}

