//
//  PlanetPairs.swift
//  
//
//  Created by Vincent on 6/23/21.
//

import Foundation

/// All possible combinations of planets
public struct PlanetPairs {
    
    /// Holds all possible pairs of planets.
    public private (set) var pairs = [Pair<Planet, Planet>]()
    
    /// Creates an instance of `PlanetPairs`.
    public init() {
        var outerIdx = 0
        let planets = Planet.allCases
        while outerIdx < planets.count - 1 {
            for innerIdx in outerIdx + 1..<planets.count {
                pairs.append(
                    Pair<Planet, Planet>(a: planets[outerIdx], b: planets[innerIdx])
                )
            }
            outerIdx += 1
        }
    }
}
