//
//  Cusp.swift
//  
//
//  Created by Vincent Smithers on 08.02.21.
//

import Foundation

/// Models the point between two houses
public struct Cusp {

	/// The degree of the coordinate
	public let value: Double

	/// Creates a `Cusp`.
	/// - Parameter value: The latitudinal degree to set.
	public init(value: Double) {
		self.value = value
	}
}

// MARK: - ZodiacCoordinate Conformance

extension Cusp: ZodiacCoordinate {}
