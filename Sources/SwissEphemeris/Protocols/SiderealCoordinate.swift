//
//  SiderealCoordinate.swift
//  
//
//  Created by Vincent Smithers on 16.03.21.
//

import Foundation

/// Models a sidereal coordinate on the Zodiac.
public struct SiderealCoordinate<T: CelestialBody> {
	
    ///
    public let date: Date
	/// The coordinate to set
	private let coordinate: Coordinate<T>
	/// The ayanamsha value that determines the sidereal position
	private let ayanamshaValue: Double
	
	/// Creates a `SiderealCoordinate`.
	/// - Parameter coordinate: The coordinate to set.
	/// - Parameter ayanamshaValue: The ayanamsha value that determines the sidereal position.
	public init(coordinate: Coordinate<T>, ayanamshaValue: Double = Ayanamsha.current) {
        self.date = coordinate.date
		self.coordinate = coordinate
		self.ayanamshaValue = ayanamshaValue
	}
}

// MARK: - ZodiacCoordinate Conformance

extension SiderealCoordinate: ZodiacCoordinate {

	public var value: Double {
		// If in the first degrees of Aries
		if coordinate.longitude - ayanamshaValue < 0 {
			return 360 - abs(coordinate.longitude - ayanamshaValue)
		} else {
			return coordinate.longitude - ayanamshaValue
		}
	}
}
