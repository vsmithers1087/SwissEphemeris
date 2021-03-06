//
//  Astroid.swift
//  
//
//  Created by Vincent Smithers on 13.02.21.
//

import Foundation

/// Models select Astroids available in the IPL.
public enum Astroid: Int32 {
	case chiron = 15
	case pholus
	case ceres
	case pallas
	case juno
	case vesta
}

// MARK: - CelestialBody Conformance

extension Astroid: CelestialBody {
	public var value: Int32 {
		rawValue
	}
}
