import XCTest
@testable import SwissEphemeris

final class PerformanceTests: XCTestCase {
    
    private var date: Date!
    private let latitude: Double = 37.5081153
    private let longitude: Double = -122.2854528
    
    override func setUpWithError() throws {
        date = try Mock.date(from: "2021-06-21T01:11:00-0001")
        JPLFileManager.setEphemerisPath()
    }
    
    func testCoordinatePerformance() throws {
        measure {
            for day in 0...1065 {
                Planet.allCases.forEach {
                    XCTAssertNotNil(Coordinate<Planet>(body: $0, date: date))
                    print("x")
                    if #available(iOS 13.0, *) {
                        date = date.advanced(by: (60 * 60 * 24) * TimeInterval(day))
                    }
                }
            }
        }
    }
    
    func testHouseCuspsPerformance() {
        measure {
            for day in 0...365 {
                HouseSystem.allCases.forEach {
                    XCTAssertNotNil(HouseCusps(date: date,
                                               latitude: latitude,
                                               longitude: longitude,
                                               houseSystem: $0))
                    if #available(iOS 13.0, *) {
                        date = date.advanced(by: (60 * 60 * 24) * TimeInterval(day))
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
    }
    
    func testRiseTimePerfomance() {
        measure {
            for day in 0...730 {
                XCTAssertNotNil(
                    RiseTime<Planet>(date: date,
                                     body: .moon,
                                     longitude: longitude,
                                     latitude: latitude)
                )
                if #available(iOS 13.0, *) {
                    date = date.advanced(by: (60 * 60 * 24) * TimeInterval(day))
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
    func testSetTimePerformance() {
        measure {
            for day in 0...730 {
                XCTAssertNotNil(
                    SetTime<Planet>(date: date,
                                     body: .moon,
                                     longitude: longitude,
                                     latitude: latitude)
                )
                if #available(iOS 13.0, *) {
                    date = date.advanced(by: (60 * 60 * 24) * TimeInterval(day))
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
    func testLunationPerformance() {
        measure {
            for day in 0...730 {
                XCTAssertNotNil(Lunation(date: date))
                if #available(iOS 13.0, *) {
                    date = date.advanced(by: (60 * 60 * 24) * TimeInterval(day))
                } 
            }
        }
    }
    
    func testAspectPerformance() {
        let PlanetPairs = PlanetPairs()
        measure {
            for day in 0...1365 {
                PlanetPairs.pairs.forEach {
                    let _ = Aspect(pair: $0, date: date)
                }
                if #available(iOS 13.0, *) {
                    date = date.advanced(by: (60 * 60 * 24) * TimeInterval(day))
                }
            }
        }
    }
    
    func testSpringEquinoxDatePerformance() {
        measure {
            var coordinate = Coordinate<Planet>(body: .sun, date: date)
            while coordinate.value > 1.0 {
                coordinate = Coordinate(body: .sun, date: coordinate.date.addingTimeInterval(60 * 60 * 12))
            }
        }
    }
    
    func testAutumnalEquinoxDatePerformance() {
        measure {
            var coordinate = Coordinate<Planet>(body: .sun, date: date)
            while Int(coordinate.value) != 180 {
                coordinate = Coordinate(body: .sun, date: coordinate.date.addingTimeInterval(60 * 60 * 12))
            }
        }
    }
    
    func testBatchRequestPlanetCoordinates() {
        let planetsRequest = PlanetsRequest(body: .moon)
        measure {
            planetsRequest.fetch(start: date, end: date.addingTimeInterval(60 * 60 * 24 * 30)) {
                XCTAssertEqual($0.count, 43200)
            }
        }
    }
    
    func testBatchRequestLunations() {
        let lunationsRequest = LunationsRequest()
        measure {
            lunationsRequest.fetch(start: date, end: date.addingTimeInterval(60 * 60 * 24 * 30), interval: 60 * 60) {
                XCTAssertEqual($0.count, 720)
            }
        }
    }
    
    static var allTests = [
        ("testCoordinatePerformance",testCoordinatePerformance,
         "testHouseCuspsPerformance", testHouseCuspsPerformance,
         "testRiseTimePerfomance", testRiseTimePerfomance,
         "testSetTimePerformance", testSetTimePerformance,
         "testLunationPerformance", testLunationPerformance,
         "testAspectPerformance", testAspectPerformance,
         "testSpringEquinoxDatePerformance", testSpringEquinoxDatePerformance,
         "testAutumnalEquinoxDatePerformance", testAutumnalEquinoxDatePerformance,
         "testBatchRequestPlanetCoordinates", testBatchRequestPlanetCoordinates,
         "testBatchRequestLunations", testBatchRequestLunations)
    ]
}
