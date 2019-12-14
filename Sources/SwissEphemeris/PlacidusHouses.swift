//
//  PlacidusHouses.swift
//  
//
//  26.12.19.
//

import CSwissEphemeris
import Foundation

/// House cusps, ascendent, descendent, MC, and IC for Placidus House System determined by date and location
public struct PlacidusHouses {
    
    /// Models point between two houses
    public struct Cusp: Coordinate {
        /// The time for which the coordinate is valid
        public let date: Date
        /// The degree of the coordinate
        public let degree: Double
        /// Where the coordinate maps to the zodiac
        public var tropicalZodiacPosition: TropicalZodiacPosition {
            TropicalZodiacPosition(degree: degree)
        }
        /// Initialized within `PlacidusHouse`
        /// - Parameters:
        ///   - date: The time at which the cusp is valid
        ///   - degree: The degree to set
        public init(date: Date, degree: Double) {
            self.date = date
            self.degree = degree
        }
    }

    /// The time at which the house system is valid
    public let date: Date
    /// The pointer passed into `setHouseSystem(julianDate, latitude, longitude, ascendentPointer, cuspPointer)`
    /// `ascPointer` argument
    private let ascendentPointer = UnsafeMutablePointer<Double>.allocate(capacity: 10)
    /// The pointer passed into `setHouseSystem(julianDate, latitude, longitude, ascendentPointer, cuspPointer)`
    /// `cuspPointer` argument
    /// This is not used because it is not relevant to ascendent data
    private let cuspPointer = UnsafeMutablePointer<Double>.allocate(capacity: 13)
    /// The location latitude for the house layout
    private let latitude: Double
    /// The locations longitude for the house layout
    private let longitude: Double
    /// Point of ascendent
    public var ascendent: Cusp {
        Cusp(date: date, degree: ascendentPointer[0])
    }
    /// Point of descendent
    public var descendent: Cusp {
        Cusp(date: date, degree: ascendentPointer[0] - 180.0)
    }
    /// Point of IC
    public var ic: Cusp {
        Cusp(date: date, degree: ascendentPointer[1] + 180.0)
    }
    /// Point of MC
    public var midHeaven: Coordinate {
        Cusp(date: date, degree: ascendentPointer[1])
    }
    /// Cusp between twelth and first house
    public var firstCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[1])
    }
    /// Cusp between first and second house
    public var secondCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[2])
    }
    /// Cusp between second and third house
    public var thirdCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[3])
    }
    /// Cusp between third and fourth house
    public var fourthCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[4])
    }
    /// Cusp between fourth and fifth house
    public var fifthCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[5])
    }
    /// Cusp between fifth and sixth house
    public var sixthCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[6])
    }
    /// Cusp between sixth and seventh house
    public var seventhCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[7])
    }
    /// Cusp between seventh and eigth house
    public var eigthCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[8])
    }
    /// Cusp between eigth and ninth house
    public var ninthCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[9])
    }
    /// Cusp between the ninth and tenth house
    public var tenthCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[10])
    }
    /// Cusp between the tenth and eleventh house
    public var eleventhCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[11])
    }
    /// Cusp between the eleventh and twelth house
    public var twelthCusp: Cusp {
        Cusp(date: date, degree: cuspPointer[12])
    }
    
    /// The preferred initializer
    /// - Parameters:
    ///   - date: The date for the houses to be laid out
    ///   - latitude: The location latitude for the house system
    ///   - longitude: The locations longitude for the house system
    public init(date: Date,
                latitude: Double,
                longitude: Double) {
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        setHouseSystem(date.julianDate(),
                       latitude,
                       longitude,
                       ascendentPointer, cuspPointer)
    }
}
