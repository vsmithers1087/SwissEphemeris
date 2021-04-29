//
//  Date+JulianDate.swift
//  
//
//  07.12.19.
//

import Foundation

import CSwissEphemeris

public extension Date {
    /// Returns a Julian date number from a `Date`
    /// Julian date format seems to be the preferred format for the ephemeris
    func julianDate() -> Double {
        let julianDateJan11970000GMT = 2440587.5
        return julianDateJan11970000GMT + timeIntervalSince1970 / 86400
    }

	init(julianDate: Double) {
		let julianDateJan11970000GMT = 2440587.5
		self = Date(timeIntervalSince1970: (julianDate - julianDateJan11970000GMT) * 86400)
	}
	
	func julianCalendarDate() -> Double {
		let components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self)
		guard let year = components.year,
			  let month = components.month,
			  let day = components.day,
			  let hour = components.hour else { return .zero}
		return swe_julday(Int32(year), Int32(month), Int32(day), Double(hour), SE_GREG_CAL);
	}
}
