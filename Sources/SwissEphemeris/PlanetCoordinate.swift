//
//  PlanetCoordinate.swift
//  
//
//  08.12.19.
//

import Foundation
import CSwissEphemeris

/// A type modeling a coordinate for a planet at a specific date
public struct PlanetCoordinate: Coordinate {
    /// The planet to model
    public let planet: Planet
    /// The time at which the coordinate degree is valid
    public let date: Date
    /// The value returned from the ephemeris
    /// Calls C method `getPlanetCoordinate(julianDate, planet)`
    public var degree: Double {
        getPlanetCoordinate(date.julianDate(), planet.rawValue)
    }
    /// The coordinate location on the tropical zodiac
    public var tropicalZodiacPosition: TropicalZodiacPosition {
        TropicalZodiacPosition(degree: degree)
    }
    /// Preferred initializer
    /// - Parameters:
    ///   - planet: The planet for the coordinate
    ///   - date: The date for the coordinate
    public init(planet: Planet, date: Date) {
        self.planet = planet
        self.date = date
    }
}
