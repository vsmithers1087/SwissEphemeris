//
//  Pair.swift
//  
//
//  Created by Vincent Smithers on 15.02.21.
//

import Foundation

/// Models a pair of `CelestialBody`.
public struct Pair<T: CelestialBody, U: CelestialBody> {
	
	/// The first body in the pair.
	public let a: T
	/// The second body in the pair.
	public let b: U
	
	/// Creates a `Pair` of celestial bodies.
	/// - Parameters:
	///   - a: The first body in the pair.
	///   - b: The second body in the pair.
	public init(a: T, b: U) {
		self.a = a
		self.b = b
	}
}
