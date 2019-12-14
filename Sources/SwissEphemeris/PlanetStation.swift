//
//  PlanetStation.swift
//  
//
//  14.09.20.
//

import Foundation

public struct PlanetStation {
    
    public let coordinate: PlanetCoordinate
    
    /// Increased `coordinate` by one day.
    public var futureCoordinate: PlanetCoordinate {
        PlanetCoordinate(planet: coordinate.planet,
                         date: coordinate.date.addingTimeInterval(60 * 60 * 24))
    }
    
    public var station: Station {
        switch coordinate.degree - futureCoordinate.degree {
        case let x where x < 0:
            return .direct
        case let x where x > 0:
            return .retrograde
        default:
            return .stationary
        }
    }
}
