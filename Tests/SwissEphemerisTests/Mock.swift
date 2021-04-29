//
//  Mock.swift
//  
//
//  14.09.20.
//

import Foundation
import XCTest

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
	
	static func date(year: Int,
					 month: Int,
					 day: Int,
					 hour: Int,
					 minute: Int,
					 second: Int) -> Date? {
		let components = DateComponents(calendar: Calendar.init(identifier: .gregorian),
										year: year,
										month: month,
										day: day,
										hour: hour,
										minute: minute,
										second: second)
		return Calendar.current.date(from: components)
	}
	
	static func date(from timestamp: String) throws -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		return try XCTUnwrap(dateFormatter.date(from:timestamp))
	}
}
