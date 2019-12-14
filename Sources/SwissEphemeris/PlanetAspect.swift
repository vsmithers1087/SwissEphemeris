//
//  PlanetAspect.swift
//  
//
//  12.09.20.
//

import Foundation

public struct PlanetAspect {
    
    public enum Direction: Equatable {
        case applying
        case separating
    }
    
    /// The point be aspected.
    /// The first point in the aspect description when read from the left to the right.
    public let subjectDegree: Double
    /// The point applying an aspect toward.
    /// The second planet in the aspect description when read from the left to right.
    public let objectDegree: Double
    /// The amount that differs from the exactness of the aspect.
    public let orb: Double
    
    /// If an aspect is approaching exactness or declining from an exact point.
    public var direction: Direction {
        objectDegree < subjectDegree ? .separating : .applying
    }

    /// The geometric relationship between two points.
    public var aspectRelationship: Double {
       abs(objectDegree - subjectDegree) >= 180 ?
        abs(abs(objectDegree - subjectDegree) - 360) :
        abs(objectDegree - subjectDegree)
    }
    
    public var aspect: Aspect? {
        Aspect(relationship: aspectRelationship, orb: orb)
    }
	
	public init(subjectDegree: Double, objectDegree: Double, orb: Double) {
		self.subjectDegree = subjectDegree
		self.objectDegree = objectDegree
		self.orb = orb
	}
}
