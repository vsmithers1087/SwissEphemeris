//
//  Station.swift
//  
//
//  14.09.20.
//

import Foundation

/// Models a direction of a `CelestialBody`.
/// This is calculated by comparing the coordinate longitude with the longitude 24 hours in the future.
public enum Station<T: CelestialBody>: Equatable {
	
	/// Moves forward.
    case direct
	/// Stays in place.
    case stationary
	/// Moves backwards.
    case retrograde
	
	/// Creates a `Station`.
	/// - Parameter coordinate: The `Coordinate` to get the direction for.
	/// - Parameter timeInterval: The interval of time to compare the coordinate longitude. The default is 24 hours.
	public init(coordinate: Coordinate<T>, timeInterval: Double = 60 * 60 * 24) {
		let modDate = coordinate.date.addingTimeInterval(timeInterval)
		switch coordinate.value - Coordinate(body: coordinate.body, date: modDate).value {
		case let x where x < 0:
			self = .direct
		case let x where x > 0:
			self = .retrograde
		default:
			self = .stationary
		}
	}
}



