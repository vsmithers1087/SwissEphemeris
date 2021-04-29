//
//  Aspect.swift
//  
//
//  29.08.20.
//

import Foundation

/// Models a geometric aspect between two bodies.
public enum Aspect: Equatable, Hashable {
    
	/// A 0° alignment.
    case conjunction(Double)
	/// A 60° alignment.
    case sextile(Double)
	/// A 90° alignment.
    case square(Double)
	/// A 120° alignment.
    case trine(Double)
	/// An 180° alignment.
    case opposition(Double)
	
	/// Creates an optional `Aspect`. If there is no aspect within the orb, then this initializer will return `nil`.
	/// - Parameters:
	///   - pair: The two bodies to compare.
	///   - date: The date of the alignment.
	///   - orb: The number of degrees allowed for the aspect to differ from exactness.
	public init?<T, U>(pair: Pair<T, U>, date: Date, orb: Double) {
		let degreeA = Coordinate(body: pair.a, date: date)
		let degreeB = Coordinate(body: pair.b, date: date)
		self.init(a: degreeA.value, b: degreeB.value, orb: orb)
	}
	
	/// Creates an optional `Aspect` between two degrees. If there is no aspect within the orb, then this initializer will return `nil`.
	/// - Parameters:
	///   - a: The first degree in the pair.
	///   - b: The second degree in the pair.
	///   - orb: The number of degrees allowed for the aspect to differ from exactness.
	public init?(a: Double, b: Double, orb: Double) {
		let aspectValue = abs(b - a) >= 180 ?
			abs(abs(b - a) - 360) : abs(b - a)
		switch aspectValue {
		case (0 - orb)...(0 + orb):
			self = .conjunction(round(aspectValue * 100) / 100)
		case (60 - orb)...(60 + orb):
			self = .sextile(round((aspectValue - 60) * 100) / 100)
		case (90 - orb)...(90 + orb):
			self = .square(round((aspectValue - 90) * 100) / 100)
		case (120 - orb)...(120 + orb):
			self = .trine(round((aspectValue - 120) * 100) / 100)
		case (180 - orb)...(180 + orb):
			self = .opposition(round((aspectValue - 180) * 100) / 100)
		default:
			return nil
		}
	}

	/// The symbol commonly associated with the aspect.
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
	
	/// The number of degrees from exactness.
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
