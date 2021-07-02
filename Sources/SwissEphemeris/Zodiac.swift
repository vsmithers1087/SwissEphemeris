//
//  Zodiac.swift
//  
//
//  07.12.19.
//

import Foundation

/// Models the 12 zodiac signs commonly used in astrological systems.
public enum Zodiac: Int, Codable {
    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capricorn
    case aquarius
    case pisces
    
	/// The astrological glyph commonly associated with the sign.
    public var symbol: String {
        switch self {
        case .aries:
            return "♈︎"
        case .taurus:
            return "♉︎"
        case .gemini:
            return "♊︎"
        case .cancer:
            return "♋︎"
        case .leo:
            return "♌︎"
        case .virgo:
            return "♍︎"
        case .libra:
            return "♎︎"
        case .scorpio:
            return "♏︎"
        case .sagittarius:
            return "♐︎"
        case .capricorn:
            return "♑︎"
        case .aquarius:
            return "♒︎"
        case .pisces:
            return "♓︎"
        }
    }
    
	/// The name of the sign formatted with the `symbol`.
    public var formatted: String {
        switch self {
        case .aries:
            return "Aries ♈︎"
        case .taurus:
            return "Taurus ♉︎"
        case .gemini:
            return "Gemini ♊︎"
        case .cancer:
            return "Cancer ♋︎"
        case .leo:
            return "Leo ♌︎"
        case .virgo:
            return "Virgo ♍︎"
        case .libra:
            return "Libra ♎︎"
        case .scorpio:
            return "Scorpio ♏︎"
        case .sagittarius:
            return "Sagittarius ♐︎"
        case .capricorn:
            return "Capricorn ♑︎"
        case .aquarius:
            return "Aquarius ♒︎"
        case .pisces:
            return "Pisces ♓︎"
        }
    }
}

extension Zodiac: CaseIterable, Equatable {}
