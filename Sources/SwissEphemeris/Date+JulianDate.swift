//
//  Date+JulianDate.swift
//  
//
//  07.12.19.
//

import Foundation

public extension Date {
    /// Returns a Julian date number from a `Date`
    /// Julian date format seems to be the preferred format for the ephemeris
    func julianDate() -> Double {
        let julianDateJan11970000GMT = 2440587.5
        return julianDateJan11970000GMT + timeIntervalSince1970 / 86400
    }
}
