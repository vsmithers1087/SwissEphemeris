//
//  Cusp.swift
//  
//
//  Created by Vincent Smithers on 08.02.21.
//

import Foundation

/// Models the point between two houses
public struct Cusp: ZodiacMappable {

	public let tropical: ZodiacCoordinate
	public let sidereal: ZodiacCoordinate

	/// Creates a `Cusp`.
	/// - Parameter value: The latitudinal degree to set.
	/// - Parameter date: The `Date` needed to map to the zodiacs.
	public init(value: Double, date: Date) {
		tropical = ZodiacCoordinate(value: value)
		sidereal = ZodiacCoordinate(value: value, offset: Ayanamsha()(for: date))
	}
}
