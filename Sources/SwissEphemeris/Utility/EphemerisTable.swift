//
//  EphemerisTable.swift
//  
//
//  Created by Vincent on 7/9/21.
//

import Foundation

/// Models a classic ephemeris table for a date.
public struct EphemerisTable {
    ///
    public let date: Date
    ///
    public let planets: [Coordinate<Planet>]
    ///
    public let lunarNodes: [Coordinate<LunarNode>]
    ///
    public let astroids: [Coordinate<Astroid>]
    ///
    public let lunation: Lunation
    
    /// <#Description#>
    /// - Parameter date: <#date description#>
    init(date: Date) {
        self.date = date
        self.planets = Planet.allCases.map({ Coordinate<Planet>(body: $0, date: date) })
        self.lunarNodes = LunarNode.allCases.map({ Coordinate<LunarNode>(body: $0, date: date) })
        self.astroids = Astroid.allCases.map({ Coordinate<Astroid>(body: $0, date: date) })
        self.lunation = Lunation(date: date)
    }
}

// MARK: - Codable Conformance

extension EphemerisTable: Codable {
    
    public enum CodingKeys: CodingKey {
        case date
        case coordinates
        case lunarNodes
        case astroids
        case lunation
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        planets = try container.decode([Coordinate<Planet>].self, forKey: .coordinates)
        lunarNodes =  try container.decode([Coordinate<LunarNode>].self, forKey: .lunarNodes)
        astroids = try container.decode([Coordinate<Astroid>].self, forKey: .astroids)
        lunation = try container.decode(Lunation.self, forKey: .lunation)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(planets, forKey: .coordinates)
        try container.encode(lunarNodes, forKey: .lunarNodes)
        try container.encode(astroids, forKey: .astroids)
        try container.encode(lunation, forKey: .lunation)
    }
}
