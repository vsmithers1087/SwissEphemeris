//
//  BodiesRequestTests.swift
//  
//
//  Created by Sam Krishna on 3/7/22.
//

import XCTest
@testable import SwissEphemeris

final class BodiesRequestTests: XCTestCase {

    override func setUpWithError() throws {
        JPLFileManager.setEphemerisPath()
    }

    /// Modify `startDate` to have a different testing start date window for lunar transits
    static var testStartDate: Date {
        let dob = "2022-03-07 13:00:00 -0800"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return dateFormatter.date(from:dob)!
    }

    static var testEndDate: Date {
        let dob = "2022-03-14 13:00:00 -0800"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return dateFormatter.date(from:dob)!
    }

    static var birthDate: Date {
        let dob = "1989-01-10 09:03:00 -0800"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return dateFormatter.date(from:dob)!
    }

    static var houseSystem: HouseCusps {
        let lat = 33.9791793
        let long = -118.032844
        return HouseCusps(date: birthDate, latitude: lat, longitude: long, houseSystem: .placidus)
    }

    static var planets: [String : Coordinate<Planet>] {
        let dict = [
            Planet.sun.formatted : Coordinate(body: Planet.sun, date: birthDate),
            Planet.moon.formatted : Coordinate(body: .moon, date: birthDate),
            Planet.mercury.formatted : Coordinate(body: .mercury, date: birthDate),
            Planet.venus.formatted : Coordinate(body: .venus, date: birthDate),
            Planet.mars.formatted : Coordinate(body: .mars, date: birthDate),
            Planet.jupiter.formatted : Coordinate(body: .jupiter, date: birthDate),
            Planet.saturn.formatted : Coordinate(body: .saturn, date: birthDate),
            Planet.uranus.formatted : Coordinate(body: .uranus, date: birthDate),
            Planet.neptune.formatted : Coordinate(body: .neptune, date: birthDate),
            Planet.pluto.formatted : Coordinate(body: .pluto, date: birthDate)
        ]

        return dict
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhittierConjunctions() throws {
        let start = BodiesRequestTests.testStartDate
        let end = BodiesRequestTests.testEndDate
        var moonConjunctions = [String : Coordinate<Planet>]()

        for (planetName, planet) in BodiesRequestTests.planets {
            let nearestHourMoonPosition = BodiesRequest(body: Planet.moon).fetch(start: start, end: end, interval: Double(60 * 60))
                .filter { $0.longitudeDelta(other: planet) < 1 }
                .min { lhs, rhs in
                    return lhs.longitudeDelta(other: planet) < rhs.longitudeDelta(other: planet)
                }

            guard let nearestHourMoonPosition = nearestHourMoonPosition else {
                continue
            }

            let detailDate = nearestHourMoonPosition.date
            let minStart = detailDate.addingTimeInterval(-30 * 60.0)
            let minEnd = detailDate.addingTimeInterval(30 * 60.0)

            // Then slice it to the per-minute basis next
            let nearestMinuteMoonPosition = BodiesRequest(body: Planet.moon).fetch(start: minStart, end: minEnd, interval: 60.0)
                .min { lhs, rhs in
                    return lhs.longitudeDelta(other: planet) < rhs.longitudeDelta(other: planet)
                }

            guard let nearestMinuteMoonPosition = nearestMinuteMoonPosition else {
                continue
            }

            moonConjunctions[planetName] = nearestMinuteMoonPosition
        }

        XCTAssertTrue(moonConjunctions.count == 1)
        guard let moonConjunctionMoment = moonConjunctions[Planet.jupiter.formatted] else {
            return;
        }

        XCTAssertNotNil(moonConjunctionMoment)
    }
}
