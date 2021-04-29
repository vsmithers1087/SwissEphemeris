//
//  SetTime.swift
//  
//
//  Created by Vincent Smithers on 15.03.21.
//

import Foundation

import CSwissEphemeris

/// Models the precise setting time for a celestial body.
public struct SetTime<T: CelestialBody> {
	
	/// The precise date of the set.
	public let date: Date?
	
	/// Creates an instance of `SetTime`.
	/// - Parameters:
	///   - timeZone: The `TimeZone` for the set.
	///   - date: The date to set for the set.
	///   - body: The celestial body that is setting.
	///   - longitude: The longitude of the location.
	///   - latitude: The latitude of the location.
	///   - altitude: The height above sea level. The default value is zero.
	///   - atmosphericPressure: The level of atmospheric pressure. The default value is zero.
	///   - atmosphericTemperature: The atmospheric temperature. The default value is zero.
	public init(timeZone: TimeZone = TimeZone.current,
				date: Date,
				body: T,
				longitude: Double,
				latitude: Double,
				altitude: Double = .zero,
				atmosphericPressure: Double = .zero,
				atmosphericTemperature: Double = .zero) {
		let geoPos = UnsafeMutablePointer<Double>.allocate(capacity: 3)
		geoPos[0] = longitude
		geoPos[1] = latitude
		geoPos[2] = altitude
		let time = UnsafeMutablePointer<Double>.allocate(capacity: 1)
		if let value = body.value as? Int32 {
			swe_rise_trans(date.julianDate(),
						   value,
						   nil,
						   SEFLG_SWIEPH,
						   2,
						   geoPos,
						   atmosphericPressure,
						   atmosphericTemperature,
						   time,
						   nil)
		}
		self.date = Date(julianDate: time[0]).addingTimeInterval(TimeInterval(timeZone.secondsFromGMT()))
	}
}
