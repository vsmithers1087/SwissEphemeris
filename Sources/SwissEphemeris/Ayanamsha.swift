//
//  Ayanamsha.swift
//  
//
//  Created by Vincent Smithers on 09.03.21.
//

import Foundation

import CSwissEphemeris


/// Models ayanamsha for a given date.
public struct Ayanamsha {
	
	public static let current: Double = swe_get_ayanamsa(Date().julianDate())
	
	/// A helper method for getting the ayanamsha number for a date.
	public func callAsFunction(for date: Date) -> Double {
		swe_get_ayanamsa(date.julianDate())
	}
}
