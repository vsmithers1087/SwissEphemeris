//
//  FixedStar.swift
//  
//
//  Created by Vincent Smithers on 24.03.21.
//

import Foundation

///
public enum FixedStar: String, CaseIterable {
	///
	case galacticCenter
	///
	case aldebaran
	///
	case antares
	///
	case regulus
	///
	case sirius
	///
	case spica
	///
	case algol
	///
	case rigel
	///
	case altair
	///
	case capella
	///
	case arcturus
	///
	case procyon
	///
	case castor
	///
	case pollux
	///
	case betelgeuse
}

// MARK: CelestialBody Conformance

extension FixedStar: CelestialBody {
	public var value: String { rawValue }
}

