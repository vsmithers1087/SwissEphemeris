//
//  ZodiacMappable.swift
//  
//
//  Created by Vincent Smithers on 6/5/22.
//

import Foundation

/// Interface for both mapping both zodiacs to coordinates.
public protocol ZodiacMappable {
	/// The coordinate for the tropical zodiac.
	var tropical: ZodiacCoordinate { get }
	/// The coordinate for the sidereal zodiac.
	var sidereal: ZodiacCoordinate { get }
}
