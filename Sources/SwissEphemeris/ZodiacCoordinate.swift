//
//  ZodiacCoordinate.swift
//  
//
//  Created by Vincent Smithers on 11.02.21.
//

import Foundation

/// Models a degree along the twelve signs of the zodiac.
public struct ZodiacCoordinate: Codable {
	/// The degree to of zodiac. Between 0 - 360.
	public let value: Double
	/// The sign that houses the degree.
	public var sign: Zodiac {  Zodiac(rawValue: Int(value / 30))! }
	///
	public var lunarMansion: LunarMansion { LunarMansion(rawValue: Int(value / 12.857142857142857)) ?? .batnAlHut  }
	/// The degree within the sign. Between 0 - 30.
	public var degree: Double { value.truncatingRemainder(dividingBy: 30) }
	/// The minute value for the degree.
	public var minute: Double { value.truncatingRemainder(dividingBy: 1) * 60 }
	/// The second value for the degree.
	public var second: Double { minute.truncatingRemainder(dividingBy: 1) * 60  }
	
	/// An initializer for creating a `ZodiacCoordinate`.
	/// - Parameter value: Must be between 0-360.
	public init(value: Double) {
		self.value = value
	}
	
	/// An initializer for creating a `ZodiacCoordinate` with an offset.
	/// - Parameters:
	///   - value: Must be between 0-360.
	///   - offset: The offset to set.
	public init(value: Double, offset: Double) {
		self.value = value - offset >= 0 ? value - offset : 360.0 + value - offset
	}
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
