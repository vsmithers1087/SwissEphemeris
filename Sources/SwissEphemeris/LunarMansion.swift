//
//  LunarMansion.swift
//  
//
//  Created by Vincent Smithers on 27.03.21.
//

import Foundation

///
public enum LunarMansion: Int {
	
	case alSharatain
	case alButayn
	case alThuraiya
	case alDabaran
	case alHaqa
	case alHana
	case alDhira
	case alNathrah
	case alTarf
	case alJabhah
	case alZubrah
	case alSarfah
	case alAwwa
	case alSimak
	case alGhafr
	case alZubana
	case alIklil
	case alQalb
	case alShaulah
	case alNaaim
	case alBaldah
	case saedAlDhabih
	case saedBula
	case saedAlSuud
	case saedAlAkhbiyah
	case alFarghAlAwwal
	case alFarghAlThani
	case batnAlHut
	
	public var formatted: String {
		switch self {
		case .alSharatain:
			return "Al Sharatain (1st)"
		case .alButayn:
			return "Al Butayn (2nd)"
		case .alThuraiya:
			return "Al Thuraiya (3rd)"
		case .alDabaran:
			return "Al Dabaran (4th)"
		case .alHaqa:
			return "Al Haqa (5th)"
		case .alHana:
			return "Al Hana (6th)"
		case .alDhira:
			return "Al Dhira (7th)"
		case .alNathrah:
			return "Al Nathrah (8th)"
		case .alTarf:
			return "Al Tarf (9th)"
		case .alJabhah:
			return "Al Jabhah (10th)"
		case .alZubrah:
			return "Al Zubrah (11th)"
		case .alSarfah:
			return "Al Sarfah (12th)"
		case .alAwwa:
			return "Al Awwa (13th)"
		case .alSimak:
			return "Al Simak (14th)"
		case .alGhafr:
			return "Al Ghafr (15th)"
		case .alZubana:
			return "Al Zubana (16th)"
		case .alIklil:
			return "Al Iklil (17th)"
		case .alQalb:
			return "Al Qalb (18th)"
		case .alShaulah:
			return "Al Shaulah (19th)"
		case .alNaaim:
			return "Al Naaim (20th)"
		case .alBaldah:
			return "Al Baldah (21st)"
		case .saedAlDhabih:
			return "Sa'd Al Dhabih (22nd)"
		case .saedBula:
			return "Sa'd Bula (23rd)"
		case .saedAlSuud:
			return "Sa'd Al Suud (24th)"
		case .saedAlAkhbiyah:
			return "Sa'd Al Akhbiyah (25th)"
		case .alFarghAlAwwal:
			return "Al Fargh al-Awwal (26th)"
		case .alFarghAlThani:
			return "Al Fargh al-Thani (27th)"
		case .batnAlHut:
			return "Batn al-Hut (28th)"
		}
	}
}
