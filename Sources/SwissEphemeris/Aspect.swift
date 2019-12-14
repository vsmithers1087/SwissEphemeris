//
//  Aspect.swift
//  
//
//  29.08.20.
//

import Foundation

public enum Aspect: Equatable {
    
    case conjunction(Double)
    case sextile(Double)
    case square(Double)
    case trine(Double)
    case opposition(Double)
    
    public init?(relationship: Double, orb: Double) {
        switch relationship {
        case (0 - orb)...(0 + orb):
            self = .conjunction(round(relationship * 100) / 100)
        case (60 - orb)...(60 + orb):
            self = .sextile(round((relationship - 60) * 100) / 100)
        case (90 - orb)...(90 + orb):
            self = .square(round((relationship - 90) * 100) / 100)
        case (120 - orb)...(120 + orb):
            self = .trine(round((relationship - 120) * 100) / 100)
        case (180 - orb)...(180 + orb):
            self = .opposition(round((relationship - 180) * 100) / 100)
        default:
            return nil
        }
    }
    
    public var symbol: String? {
        switch self {
        case .conjunction:
            return "☌"
        case .sextile:
            return "﹡"
        case .square:
            return "◾️"
        case .trine:
            return "▵"
        case .opposition:
            return "☍"
        }
    }
	
	var remainder: Double {
		switch self {
		case .conjunction(let remainder):
			return remainder
		case .sextile(let remainder):
			return remainder
		case .square(let remainder):
			return remainder
		case .trine(let remainder):
			return remainder
		case .opposition(let remainder):
			return remainder
		}
	}
}
