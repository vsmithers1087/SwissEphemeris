//
//  RiseTime.swift
//  
//
//  Created by Vincent Smithers on 09.03.21.
//

import Foundation

import CSwissEphemeris

/// Models the precise rising time for a celestial body.
public final class RiseTime<T: CelestialBody> {
	
	/// The date of the rise.
	public let date: Date?
	/// The pointer for the longitude, latitude and altitude.
	let geoPos = UnsafeMutablePointer<Double>.allocate(capacity: 3)
	/// The pointer for the time.
	let time = UnsafeMutablePointer<Double>.allocate(capacity: 1)
	
	/// Creates a `RisingTime`.
	/// - Parameters:
	///   - timeZone: The `TimeZone` for the rise.
	///   - date: The date to set for the rise.
	///   - body: The celestial body that is rising.
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
				altitude: Double,
				atmosphericPressure: Double = .zero,
				atmosphericTemperature: Double = .zero) {
		geoPos[0] = longitude
		geoPos[1] = latitude
		geoPos[2] = altitude
		if let value = body.value as? Int32 {
			swe_rise_trans(date.julianDate(),
						   value,
						   nil,
						   SEFLG_SWIEPH,
						   1,
						   geoPos,
						   atmosphericPressure,
						   atmosphericTemperature,
						   time,
						   nil)
		}
		self.date = Date(julianDate: time[0]).addingTimeInterval(TimeInterval(timeZone.secondsFromGMT()))
	}
	
	deinit {
		geoPos.deallocate()
		time.deallocate()
	}
}
