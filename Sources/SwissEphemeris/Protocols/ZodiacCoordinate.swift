//
//  ZodiacCoordinate.swift
//  
//
//  Created by Vincent Smithers on 11.02.21.
//

import Foundation

/// Models a degree along the twelve signs of the tropical zodiac.
/// https://www.astro.com/astrowiki/en/Tropical_Zodiac
public protocol ZodiacCoordinate {
	/// The degree to of zodiac. Between 0 - 360.
	var value: Double { get }
	/// The sign that houses the degree.
	var sign: Zodiac { get }
	/// The degree within the sign. Between 0 - 30.
	var degree: Double { get }
	/// The minute value for the degree.
	var minute: Double { get}
	/// The second value for the degree.
	var second: Double { get }
}

public extension ZodiacCoordinate {
	
	var sign: Zodiac { Zodiac(rawValue: Int(value / 30))! }
	
	var degree: Double { value.truncatingRemainder(dividingBy: 30) }
	
	var minute: Double { value.truncatingRemainder(dividingBy: 1) * 60 }
	
	var second: Double { minute.truncatingRemainder(dividingBy: 1) * 60 }
}

public extension ZodiacCoordinate {
	/// A readable `String` formatting the degree, sign, minute and second
	var formatted: String {
		"\(Int(degree)) Degrees " +
		"\(sign.formatted) " +
		"\(Int(minute))' " +
		"\(Int(second))''"
	}
}
