//
//  Transit.swift
//  
//
//  12.10.20.
//

import Foundation

/// Calculates the start, and end of a celestial pair aspect.
public struct Transit {
	
	/// The beginning of the transit.
	public let start: Date
	/// The end of the transit.
	public let end: Date
	
	/// Creates an optional `Transit`. If the `Pair` is not in aspect, then `nil` is returned.
	/// - Parameters:
	///   - pair: The pair of celestial bodies in potential aspect.
	///   - date: The date of the transit.
	///   - orb: The number of degrees allowed for the aspect to differ from exactness.
	public init?<T, U>(pair: Pair<T, U>, date: Date, orb: Double) {
		start = Self.date(pair: pair, date: date, orb: orb, timeInterval: -60 * 60)
		end = Self.date(pair: pair, date: date, orb: orb, timeInterval: 60 * 60)
		if start == date && end == date {
			return nil
		}
	}
}

extension Transit {
	
	/// A helper method for determining a date, when the transit is no longer.
	/// - Parameters:
	///   - pair: The pair of celestial bodies in potential aspect.
	///   - date: The date of the transit.
	///   - orb: The number of degrees allowed for the aspect to differ from exactness.
	///   - timeInterval: The time interval that determines whether pairs are still in aspect.
	/// - Returns: The date when the pair are no longer in aspect.
	private static func date<T, U>(pair: Pair<T, U>, date: Date, orb: Double, timeInterval: Double) -> Date {
		var aspect: Aspect? = Aspect(pair: pair, date: date, orb: orb)
		var modDate = date
		while aspect != nil {
			modDate = modDate.addingTimeInterval(timeInterval)
			aspect = Aspect(pair: pair, date: modDate, orb: orb)
		}
		return date
	}
}

