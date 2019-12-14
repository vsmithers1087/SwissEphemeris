//
//  Coordinate.swift
//  
//
//  07.12.19.
//

import Foundation

/// Models qualities of a coordinate for a specific date
public protocol Coordinate {
    /// The date for the location
    var date: Date { get }
    /// The 0-360 degree value representing the location
    var degree: Double { get }
    /// Where the coordinate maps to the tropical Zodiac
    var tropicalZodiacPosition: TropicalZodiacPosition { get }
}
