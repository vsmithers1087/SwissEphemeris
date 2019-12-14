//
//  TropicalZodiacPosition.swift
//  
//
//  07.12.19.
//

import Foundation

/// A type modeling a degree's location on the Tropical Zodiac
public struct TropicalZodiacPosition {
    /// The degree to map
    public let degree: Double
    /// The sign that the degree maps to
    public let sign: Zodiac
    /// A readable `String` formatting the degree, sign, minute and second
    public var formatted: String {
        "\(Int(degree)) Degrees " +
        "\(sign.formatted) " +
        "\(Int(minute))' " +
        "\(Int(second))''"
    }
    
    public var formattedShort: String {
        "\(Int(degree)) " +
        "\(sign.formattedShort) " +
        "\(Int(minute))' " +
        "\(Int(second))''"
    }
    
    /// The minute value for the degree
    public var minute: Double {
        degree.truncatingRemainder(dividingBy: 1) * 60
    }
    /// The second value for the degree
    public var second: Double {
        minute.truncatingRemainder(dividingBy: 1) * 60
    }
    /// Preferred initializer
    /// - Parameter degree: The degree to map to the zodiac
    public init(degree: Double) {
        self.degree = degree.truncatingRemainder(dividingBy: 30)
        sign = Zodiac(rawValue: Int(degree / 30))!
    }
}
