//
//  Planet.swift
//  
//
//  07.12.19.
//

import Foundation

/// Models the seven planets in tradtional astrology
public enum Planet: Int32 {
    case sun
    case moon
    case mercury
    case venus
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    case pluto
    
    public var symbol: String {
        switch self {
        case .sun:
            return "☉"
        case .moon:
            return "☾"
        case .mercury:
            return "☿"
        case .venus:
            return "♀"
        case .mars:
            return "♂︎"
        case .jupiter:
            return "♃"
        case .saturn:
            return "♄"
        case .uranus:
            return "♅"
        case .neptune:
            return "♆"
        case .pluto:
            return "♇"
        }
    }
    
    public var name: String {
        switch self {
        case .sun:
            return "Sun"
        case .moon:
            return "Moon"
        case .mercury:
            return "Mercury"
        case .venus:
            return "Venus"
        case .mars:
            return "Mars"
        case .jupiter:
            return "Jupiter"
        case .saturn:
            return "Saturn"
        case .uranus:
            return "Uranus"
        case .neptune:
            return "Neptune"
        case .pluto:
            return "Pluto"
        }
    }
    
    public var formatted: String {
        switch self {
        case .sun:
            return "☉ Sun"
        case .moon:
            return "☾ Moon"
        case .mercury:
            return "☿ Mercury"
        case .venus:
            return "♀ Venus"
        case .mars:
            return "♂️Mars"
        case .jupiter:
            return "♃ Jupiter"
        case .saturn:
            return "♄ Saturn"
        case .uranus:
            return "♅ Uranus"
        case .neptune:
            return "♆ Neptune"
        case .pluto:
            return "♇ Pluto"
        }
    }
}

extension Planet: CaseIterable {}
