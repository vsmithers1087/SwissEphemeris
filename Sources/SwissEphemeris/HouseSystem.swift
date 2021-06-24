//
//  HouseSystem.swift
//  
//
//  Created by Vincent Smithers on 10.02.21.
//

import Foundation

/// The house systems that are available when setting `HouseCusps`.
/// The the raw `Int32` values map to `hsys`.
public enum HouseSystem: Int32, CaseIterable {
	case placidus
	case koch
	case porphyrius
	case regiomontanus
	case campanus
	case equal
	case wholeSign
}
