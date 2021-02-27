//
//  Coordinate.swift
//  
//
//  Created by Vincent Smithers on 10.02.21.
//

import Foundation
import CSwissEphemeris


/// Models a `CelestialBody` point in the sky.
public struct Coordinate<T: CelestialBody> {
	
	/// The type of `CelestialBody`.
	public let body: T
	/// The date of the the coordinate.
	public let date: Date
	/// The coordinate's longitude.
	public let longitude: Double
	/// The coordinate's latitude.
	public let latitude: Double
	/// The distance in AU.
	public let distance: Double
	/// The speed in longitude (deg/day).
	public let speedLongitude: Double
	/// The speed in latitude (deg/day).
	public let speedLatitude: Double
	/// The speed in distance (AU/day).
	public let speedDistance: Double
	/// The pointer that holds all values.
	private let pointer = UnsafeMutablePointer<Double>.allocate(capacity: 6)
	
	/// Creates a `Coordinate`.
	/// - Parameters:
	///   - body: The `CelestialBody` for the placement.
	///   - date: The date for the location of the coordinate.
	public init(body: T, date: Date) {
		self.body = body
		self.date = date
		coordinate(date.julianDate(), body.value, pointer)
		longitude = pointer[0]
		latitude = pointer[1]
		distance = pointer[2]
		speedLongitude = pointer[3]
		speedLatitude = pointer[4]
		speedDistance = pointer[5]
	}
}

// MARK: - ZodiacCoordinate Conformance

extension Coordinate: ZodiacCoordinate {
	public var value: Double { longitude }
}
