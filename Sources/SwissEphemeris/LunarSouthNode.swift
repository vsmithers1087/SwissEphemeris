//
//  LunarSouthNode.swift
//  
//
//  Created by Vincent Smithers on 6/4/22.
//

import Foundation

/// Maps the Moon's south node to the zodiacs.
public struct LunarSouthNode: ZodiacMappable {
	
	public let tropical: ZodiacCoordinate
	public let sidereal: ZodiacCoordinate
	
	/// Creates a `LunarSouthNode`.
	/// - Parameter nodeCoordinate: The north lunar node coordinate.
	public init(nodeCoordinate: Coordinate<LunarNorthNode>) {
		tropical = ZodiacCoordinate(value: nodeCoordinate.longitude, offset: 180.0)
		sidereal = ZodiacCoordinate(value: nodeCoordinate.longitude, offset: 180.0 +  Ayanamsha()(for: nodeCoordinate.date))
	}
}
