//
//  Zodiac.swift
//  
//
//  07.12.19.
//

import Foundation

/// Models the 12 zodiac signs
public enum Zodiac: Int {
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
    
    public var formattedShort: String {
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
