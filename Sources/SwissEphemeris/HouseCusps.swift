//
//  HouseCusps.swift
//  
//
//  26.12.19.
//

import CSwissEphemeris
import Foundation

/// Models a house system with a `Cusp` for each house, ascendent and midheaven.
public struct HouseCusps {

    /// The time at which the house system is valid
    public let date: Date
    /// The pointer passed into `set_house_system(julianDate, latitude, longitude, ascendentPointer, cuspPointer)`
    /// `ascPointer` argument
    private let ascendentPointer = UnsafeMutablePointer<Double>.allocate(capacity: 10)
    /// The pointer passed into `set_house_system(julianDate, latitude, longitude, ascendentPointer, cuspPointer)`
    /// `cuspPointer` argument
    /// This is not used because it is not relevant to ascendent data
    private let cuspPointer = UnsafeMutablePointer<Double>.allocate(capacity: 13)
    /// Point of ascendent
	public let ascendent: Cusp
    /// Point of MC
    public let midHeaven: Cusp
    /// Cusp between twelth and first house
    public let first: Cusp
    /// Cusp between first and second house
    public let second: Cusp
    /// Cusp between second and third house
    public let third: Cusp
    /// Cusp between third and fourth house
    public let fourth: Cusp
    /// Cusp between fourth and fifth house
    public let fifth: Cusp
    /// Cusp between fifth and sixth house
    public let sixth: Cusp
    /// Cusp between sixth and seventh house
    public let seventh: Cusp
    /// Cusp between seventh and eighth house
    public let eighth: Cusp
    /// Cusp between eighth and ninth house
    public let ninth: Cusp
    /// Cusp between the ninth and tenth house
    public let tenth: Cusp
    /// Cusp between the tenth and eleventh house
    public let eleventh: Cusp
    /// Cusp between the eleventh and twelfth house
    public let twelfth: Cusp
	
	/// The preferred initializer
	/// - Parameters:
	///   - date: The date for the houses to be laid out
	///   - latitude: The location latitude for the house system
	///   - longitude: The locations longitude for the house system
	///   - houseSystem: The type of `HouseSystem`.
    public init(date: Date,
                latitude: Double,
				longitude: Double,
				houseSystem: HouseSystem) {
		defer {
			cuspPointer.deallocate()
			ascendentPointer.deallocate()
		}
        self.date = date
		swe_houses(date.julianDate(), latitude, longitude, houseSystem.rawValue, cuspPointer, ascendentPointer);
		ascendent = Cusp(value: ascendentPointer[0])
		midHeaven = Cusp(value: ascendentPointer[1])
		first = Cusp(value: cuspPointer[1])
		second = Cusp(value: cuspPointer[2])
		third = Cusp(value: cuspPointer[3])
		fourth =  Cusp(value: cuspPointer[4])
		fifth = Cusp(value: cuspPointer[5])
		sixth = Cusp(value: cuspPointer[6])
		seventh = Cusp(value: cuspPointer[7])
		eighth =  Cusp(value: cuspPointer[8])
		ninth =  Cusp(value: cuspPointer[9])
		tenth = Cusp(value: cuspPointer[10])
		eleventh = Cusp(value: cuspPointer[11])
		twelfth =  Cusp(value: cuspPointer[12])
    }
}
