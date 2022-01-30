//
//  BusinessSearch.swift
//  City Sights App
//
//  Created by Mason Garrett on 2022-01-30.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    
    var center = Coordinate()
}
