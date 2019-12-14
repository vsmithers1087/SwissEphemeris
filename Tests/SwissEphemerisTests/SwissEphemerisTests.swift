import XCTest
@testable import SwissEphemeris

final class SwissEphemerisTests: XCTestCase {

    func testSunZodiacCoordinate() {
        /// 12.14.2019 13:39 UT/GMT
        let date = Date(timeIntervalSince1970: 598023482.487818)
        let sunCoordinate = PlanetCoordinate(planet: .sun, date: date)
        XCTAssertEqual(sunCoordinate.degree, 261.78048317462486)
        XCTAssertEqual(sunCoordinate.tropicalZodiacPosition.sign, .sagittarius)
        XCTAssertEqual(sunCoordinate.tropicalZodiacPosition.formatted, "21 Degrees Sagittarius ♐︎ 46' 49''")
        XCTAssertEqual(Int(sunCoordinate.tropicalZodiacPosition.minute), 46)
        XCTAssertEqual(Int(sunCoordinate.tropicalZodiacPosition.second), 49)
    }
    
    func testPlanets() {
        for (index, planet) in Planet.allCases.enumerated() {
            switch index {
            case 0:
                XCTAssertEqual(planet.formatted, "☉ Sun")
            case 1:
                XCTAssertEqual(planet.formatted, "☾ Moon")
            case 2:
                XCTAssertEqual(planet.formatted, "☿ Mercury")
            case 3:
                XCTAssertEqual(planet.formatted, "♀ Venus")
            case 4:
                XCTAssertEqual(planet.formatted, "♂️Mars")
            case 5:
                XCTAssertEqual(planet.formatted, "♃ Jupiter")
            case 6:
                XCTAssertEqual(planet.formatted, "♄ Saturn")
            case 7:
                XCTAssertEqual(planet.formatted, "♅ Uranus")
            case 8:
                XCTAssertEqual(planet.formatted, "♆ Neptune")
            case 9:
                XCTAssertEqual(planet.formatted, "♇ Pluto")
            default:
                XCTFail("Failed because there are planets that not tested")
            }
        }
        Planet.allCases.forEach({
            let coordinate = PlanetCoordinate(planet: $0, date: Date())
            print(coordinate.tropicalZodiacPosition.formatted)
        })
    }
    
    func testZodiac() {
        for (index, sign) in Zodiac.allCases.enumerated() {
            switch index {
            case 0:
                XCTAssertEqual(sign.formatted, "Aries ♈︎")
            case 1:
                XCTAssertEqual(sign.formatted, "Taurus ♉︎")
            case 2:
                XCTAssertEqual(sign.formatted, "Gemini ♊︎")
            case 3:
                XCTAssertEqual(sign.formatted, "Cancer ♋︎")
            case 4:
                XCTAssertEqual(sign.formatted, "Leo ♌︎")
            case 5:
                XCTAssertEqual(sign.formatted, "Virgo ♍︎")
            case 6:
                XCTAssertEqual(sign.formatted, "Libra ♎︎")
            case 7:
                XCTAssertEqual(sign.formatted, "Scorpio ♏︎")
            case 8:
                XCTAssertEqual(sign.formatted, "Sagittarius ♐︎")
            case 9:
                XCTAssertEqual(sign.formatted, "Capricorn ♑︎")
            case 10:
                XCTAssertEqual(sign.formatted, "Aquarius ♒︎")
            case 11:
                XCTAssertEqual(sign.formatted, "Pisces ♓︎")
            default:
                XCTFail("Failed because there are signs that are not tested")
            }
        }
        XCTAssertNil(Zodiac(rawValue: 12))
    }

    func testAscendent() {
        let houseSystem = Mock.makeHouses()

        /// Ascendent
        let ascCoordinate = houseSystem.ascendent
        XCTAssertTrue(ascCoordinate.tropicalZodiacPosition.degree > 0)
        XCTAssertTrue(ascCoordinate.tropicalZodiacPosition.degree < 1)
        XCTAssertEqual(ascCoordinate.tropicalZodiacPosition.sign, Zodiac.sagittarius)
        XCTAssertNotNil(ascCoordinate.tropicalZodiacPosition.formatted)
        
        /// Descendent
        let desc = houseSystem.descendent
        XCTAssertTrue(desc.tropicalZodiacPosition.degree > 0)
        XCTAssertTrue(desc.tropicalZodiacPosition.degree < 1)
        XCTAssertEqual(desc.tropicalZodiacPosition.sign, Zodiac.gemini)
        
        /// MC
        let mc = houseSystem.midHeaven
        XCTAssertTrue(mc.tropicalZodiacPosition.degree > 13)
        XCTAssertTrue(mc.tropicalZodiacPosition.degree < 14)
        XCTAssertEqual(mc.tropicalZodiacPosition.sign, Zodiac.virgo)
        
        /// MC
        let ic = houseSystem.ic
        XCTAssertTrue(ic.tropicalZodiacPosition.degree > 13)
        XCTAssertTrue(ic.tropicalZodiacPosition.degree < 14)
        XCTAssertEqual(ic.tropicalZodiacPosition.sign, Zodiac.pisces)
    }
    
    func testHouses() {
        let houseSystem = Mock.makeHouses()
        /// House Cusps
        let firstHouse = houseSystem.firstCusp
        XCTAssertEqual(firstHouse.tropicalZodiacPosition.sign, Zodiac.sagittarius)
        XCTAssertTrue(firstHouse.tropicalZodiacPosition.degree > 0)
        XCTAssertTrue(firstHouse.tropicalZodiacPosition.degree < 1)
        
        let secondHouse = houseSystem.secondCusp
        XCTAssertEqual(secondHouse.tropicalZodiacPosition.sign, Zodiac.capricorn)
        XCTAssertTrue(secondHouse.tropicalZodiacPosition.degree > 1)
        XCTAssertTrue(secondHouse.tropicalZodiacPosition.degree < 2)
        
        let thirdHouse = houseSystem.thirdCusp
        XCTAssertEqual(thirdHouse.tropicalZodiacPosition.sign, Zodiac.aquarius)
        XCTAssertTrue(thirdHouse.tropicalZodiacPosition.degree > 7)
        XCTAssertTrue(thirdHouse.tropicalZodiacPosition.degree < 8)
        
        let fourthHouse = houseSystem.fourthCusp
        XCTAssertEqual(fourthHouse.tropicalZodiacPosition.sign, Zodiac.pisces)
        XCTAssertTrue(fourthHouse.tropicalZodiacPosition.degree > 13)
        XCTAssertTrue(fourthHouse.tropicalZodiacPosition.degree < 14)
        
        let fifthHouse = houseSystem.fifthCusp
        XCTAssertEqual(fifthHouse.tropicalZodiacPosition.sign, Zodiac.aries)
        XCTAssertTrue(fifthHouse.tropicalZodiacPosition.degree > 14)
        XCTAssertTrue(fifthHouse.tropicalZodiacPosition.degree < 15)
        print(fifthHouse.tropicalZodiacPosition.degree)
        
        let sixthHouse = houseSystem.sixthCusp
        XCTAssertEqual(sixthHouse.tropicalZodiacPosition.sign, Zodiac.taurus)
        XCTAssertTrue(sixthHouse.tropicalZodiacPosition.degree > 9)
        XCTAssertTrue(sixthHouse.tropicalZodiacPosition.degree < 10)
        
        let seventhHouse = houseSystem.seventhCusp
        XCTAssertEqual(seventhHouse.tropicalZodiacPosition.sign, Zodiac.gemini)
        XCTAssertTrue(seventhHouse.tropicalZodiacPosition.degree > 0)
        XCTAssertTrue(seventhHouse.tropicalZodiacPosition.degree < 1)
        print(seventhHouse.tropicalZodiacPosition.degree)
          
        let eightHouse = houseSystem.eigthCusp
        XCTAssertEqual(eightHouse.tropicalZodiacPosition.sign, Zodiac.cancer)
        XCTAssertTrue(eightHouse.tropicalZodiacPosition.degree > 1)
        XCTAssertTrue(eightHouse.tropicalZodiacPosition.degree < 2)
        print(eightHouse.tropicalZodiacPosition.degree)
        
        let ninthHouse = houseSystem.ninthCusp
        XCTAssertEqual(ninthHouse.tropicalZodiacPosition.sign, Zodiac.leo)
        XCTAssertTrue(ninthHouse.tropicalZodiacPosition.degree > 7)
        XCTAssertTrue(ninthHouse.tropicalZodiacPosition.degree < 8)
        
        let tenthHouse = houseSystem.tenthCusp
        XCTAssertEqual(tenthHouse.tropicalZodiacPosition.sign, Zodiac.virgo)
        XCTAssertTrue(tenthHouse.tropicalZodiacPosition.degree > 13)
        XCTAssertTrue(tenthHouse.tropicalZodiacPosition.degree < 14)
        
        let eleventhHouse = houseSystem.eleventhCusp
        XCTAssertEqual(eleventhHouse.tropicalZodiacPosition.sign, Zodiac.libra)
        XCTAssertTrue(eleventhHouse.tropicalZodiacPosition.degree > 14)
        XCTAssertTrue(eleventhHouse.tropicalZodiacPosition.degree < 15)
        
        let twelveHouse = houseSystem.twelthCusp
        XCTAssertEqual(twelveHouse.tropicalZodiacPosition.sign, Zodiac.scorpio)
        XCTAssertTrue(twelveHouse.tropicalZodiacPosition.degree > 9)
        XCTAssertTrue(twelveHouse.tropicalZodiacPosition.degree < 10)
    }
    
    func testAspects() {
        // Expect 64.0 relationship sextile
        let jupiter = PlanetCoordinate(planet: .jupiter, date: Mock.date)
        let moon = PlanetCoordinate(planet: .moon, date: Mock.date)
        var planetAspect = PlanetAspect(subjectDegree: jupiter.degree, objectDegree: moon.degree, orb: 8.0)
        XCTAssertEqual(planetAspect.direction, .applying)
        XCTAssertEqual(planetAspect.aspectRelationship, 63.514737770436625)
        XCTAssertEqual(planetAspect.aspect, .sextile(3.51))
        XCTAssertEqual(planetAspect.aspect?.symbol, "﹡")
        XCTAssertEqual(planetAspect.direction, .applying)
        // Expect reverse to be 64.0 sextile
        planetAspect = PlanetAspect(subjectDegree: moon.degree, objectDegree: jupiter.degree, orb: 8.0)
        XCTAssertEqual(planetAspect.aspectRelationship, 63.514737770436625)
        XCTAssertEqual(planetAspect.aspect, .sextile(3.51))
        XCTAssertEqual(planetAspect.direction, .separating)
        // Expect 3.0 relationship conjunction
        let sun = PlanetCoordinate(planet: .sun, date: Mock.date)
        let pluto = PlanetCoordinate(planet: .pluto, date: Mock.date)
        planetAspect = PlanetAspect(subjectDegree: sun.degree, objectDegree: pluto.degree, orb: 5.0)
        XCTAssertEqual(planetAspect.aspectRelationship, 3.056601922152879)
        XCTAssertEqual(planetAspect.aspect, .conjunction(3.06))
        XCTAssertEqual(planetAspect.aspect?.symbol, "☌")
        XCTAssertEqual(planetAspect.direction, .applying)
        // Expect 171.0 relationship opposition
        let mars = PlanetCoordinate(planet: .mars, date: Mock.date)
        planetAspect = PlanetAspect(subjectDegree: mars.degree, objectDegree: jupiter.degree, orb: 10)
        XCTAssertEqual(planetAspect.aspectRelationship, 171.03360216390917)
        XCTAssertEqual(planetAspect.aspect, .opposition(-8.97))
        XCTAssertEqual(planetAspect.aspect?.symbol, "☍")
        XCTAssertEqual(planetAspect.direction, .separating)
        // Expect 124.0 relationship trine
        let saturn = PlanetCoordinate(planet: .saturn, date: Mock.date)
        planetAspect = PlanetAspect(subjectDegree: saturn.degree, objectDegree: jupiter.degree, orb: 10)
        XCTAssertEqual(planetAspect.aspectRelationship, 124.64848323475161)
        XCTAssertEqual(planetAspect.aspect, .trine(4.65))
        XCTAssertEqual(planetAspect.aspect?.symbol, "▵")
        XCTAssertEqual(planetAspect.direction, .separating)
        // Expect 84.0 relationship square
        let venus = PlanetCoordinate(planet: .venus, date: Mock.date)
        planetAspect = PlanetAspect(subjectDegree: venus.degree, objectDegree: moon.degree, orb: 10)
        XCTAssertEqual(planetAspect.aspectRelationship, 84.87174558797352)
        XCTAssertEqual(planetAspect.aspect, .square(-5.13))
        XCTAssertEqual(planetAspect.aspect?.symbol, "◾️")
        XCTAssertEqual(planetAspect.direction, .applying)
        // Expect no aspect
        XCTAssertNil(PlanetAspect(subjectDegree: venus.degree, objectDegree: mars.degree, orb: 5).aspect)
    }

    func testAspectCount() {
        let sunAspects = Planet.allCases.compactMap {
            PlanetAspect(subjectDegree: PlanetCoordinate(planet: .sun, date: Mock.date).degree,
                         objectDegree: PlanetCoordinate(planet: $0, date: Mock.date).degree, orb: 10).aspect
        }
        XCTAssertEqual(sunAspects.count, 4)
        let moonAspects = Planet.allCases.compactMap {
            PlanetAspect(subjectDegree: PlanetCoordinate(planet: .moon, date: Mock.date).degree,
                         objectDegree: PlanetCoordinate(planet: $0, date: Mock.date).degree, orb: 10).aspect
        }
        XCTAssertEqual(moonAspects.count, 7)
        let mercuryAspects = Planet.allCases.compactMap {
            PlanetAspect(subjectDegree: PlanetCoordinate(planet: .mercury, date: Mock.date).degree,
                         objectDegree: PlanetCoordinate(planet: $0, date: Mock.date).degree, orb: 8).aspect
        }
        XCTAssertEqual(mercuryAspects.count, 4)
    }
    
    func testPlanetsOnAscendent() {
        let houseSystem = Mock.makeHouses()
        let ascendent = houseSystem.ascendent
        let aspects = Planet.allCases.compactMap {
            PlanetAspect(subjectDegree: ascendent.degree,
                         objectDegree: PlanetCoordinate(planet: $0, date: Mock.date).degree, orb: 10)
        }
        XCTAssertEqual(aspects.compactMap { $0.aspect }.count, 1)
        let ascendentAspect = PlanetAspect(subjectDegree: ascendent.degree,
                                           objectDegree: PlanetCoordinate(planet: .venus, date: Mock.date).degree, orb: 10)
        XCTAssertEqual(ascendentAspect.direction, .separating)
    }
    
    func testPlanetaryStation() {
        let sun = PlanetStation(coordinate: PlanetCoordinate(planet: .sun, date: Mock.date))
        XCTAssertEqual(sun.station, .direct)
        let mars = PlanetStation(coordinate: PlanetCoordinate(planet: .mars, date: Mock.date))
        XCTAssertEqual(mars.station, .direct)
        let mercury = PlanetStation(coordinate: PlanetCoordinate(planet: .mercury, date: Mock.date))
        XCTAssertEqual(mercury.station, .retrograde)
        let jupiter = PlanetStation(coordinate: PlanetCoordinate(planet: .jupiter, date: Mock.date))
        XCTAssertEqual(jupiter.station, .retrograde)
    }
    
    func testSpringEquinoxPerformance() {
        measure {
            var coordinate = PlanetCoordinate(planet: .sun, date: Date())
            while coordinate.degree > 1.0 {
                coordinate = PlanetCoordinate(planet: .sun, date: coordinate.date.addingTimeInterval(60 * 60 * 12))
            }
        }
    }
    
    func testAutumnalEquinoxPerformance() {
        measure {
            var coordinate = PlanetCoordinate(planet: .sun, date: Date())
            while Int(coordinate.degree) != 180 {
                coordinate = PlanetCoordinate(planet: .sun, date: coordinate.date.addingTimeInterval(60 * 60 * 12))
                print(coordinate.tropicalZodiacPosition)
                print(coordinate.date)
            }
        }
    }
	
	func testTransit() {
		measure {
			let subject = PlanetCoordinate(planet: .jupiter, date: Mock.date)
			let object = PlanetCoordinate(planet: .saturn, date: Mock.date)
			let transit = Transit(subject: subject, object: object, orb: 8)
			debugPrint("Start Date: \(transit.startDate) End Date: \(transit.endDate)")
		}
	}
	
	func testTransitExact() {
		measure {
			let subject = PlanetCoordinate(planet: .jupiter, date: Mock.date)
			let object = PlanetCoordinate(planet: .saturn, date: Mock.date)
			let transit = Transit(subject: subject, object: object, orb: 8)
			debugPrint("Exact Date: \(transit.exactDate)")
		}
	}
    
    static var allTests = [
        ("testSunZodiacCoordinate",testSunZodiacCoordinate,
         "testPlanets", testPlanets,
         "testZodiac", testZodiac,
         "testAscendent", testAscendent,
         "testHouses", testHouses,
         "testAspects", testAspects,
         "testPlanetaryStation", testPlanetaryStation,
         "testSpringEquinoxPerformance", testSpringEquinoxPerformance,
         "testAutumnalEquinoxPerformance", testAutumnalEquinoxPerformance),
    ]
}
