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
	/// The pointer for the longitude, latitude and altitude.
	let geoPos = UnsafeMutablePointer<Double>.allocate(capacity: 3)
	/// The pointer for the time.
	let time = UnsafeMutablePointer<Double>.allocate(capacity: 1)
	
	/// Creates an instance of `SetTime`.
	/// - Parameters:
	///   - date: The date to set for the set.
	///   - body: The celestial body that is setting.
	///   - longitude: The longitude of the location.
	///   - latitude: The latitude of the location.
	///   - altitude: The height above sea level. The default value is zero.
	///   - atmosphericPressure: The level of atmospheric pressure. The default value is zero.
	///   - atmosphericTemperature: The atmospheric temperature. The default value is zero.
	public init(date: Date,
				body: T,
				longitude: Double,
				latitude: Double,
				altitude: Double = .zero,
				atmosphericPressure: Double = .zero,
				atmosphericTemperature: Double = .zero) {
		defer {
			geoPos.deallocate()
			time.deallocate()
		}
		geoPos[0] = longitude
		geoPos[1] = latitude
		geoPos[2] = altitude
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
		self.date = Date(julianDate: time[0])
	}
}
