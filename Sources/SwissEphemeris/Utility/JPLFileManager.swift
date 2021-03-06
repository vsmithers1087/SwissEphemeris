//
//  JPLFileManager.swift
//  
//
//  Created by Vincent Smithers on 06.03.21.
//

import Foundation

import CSwissEphemeris

/// Utility class for setting the path to the ephemeris files.
public final class JPLFileManager {
	
	/// The `Bundle.module` location of the JPL files.
	public static let resourcePath = Bundle.module.resourcePath
	
	/// Sets the ephemeris path.
	/// - Parameter path: The  path of the ephemeris files. The default value is `resourcePath`.
	public static func setEphemerisPath(path: String? = resourcePath) {
		swe_set_ephe_path(strdup(path))
	}
}
