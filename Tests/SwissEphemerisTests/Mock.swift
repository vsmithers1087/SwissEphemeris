//
//  Mock.swift
//  
//
//  14.09.20.
//

import Foundation
@testable import SwissEphemeris

struct Mock {
    static var date: Date {
        let dob = "1987-10-30T08:42:00-0800"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from:dob)!
    }
    
    static func makeHouses() -> HouseCusps {
        /// Redwood City California
        let latitude: Double = 37.5081153
        let longitude: Double = -122.2854528
		return HouseCusps(date: Mock.date, latitude: latitude, longitude: longitude, houseSystem: .placidus)
    }
}
