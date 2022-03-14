//
//  Asteroid.swift
//  
//
//  Created by Vincent Smithers on 13.02.21.
//

import Foundation

/// Models select Asteroids available in the IPL.
public enum Asteroid: Int32 {
	case chiron = 15
	case pholus
	case ceres
	case pallas
	case juno
	case vesta
}

// MARK: - CelestialBody Conformance

extension Asteroid: CelestialBody {
	public var value: Int32 {
		rawValue
	}
}
