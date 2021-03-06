import XCTest
@testable import SwissEphemeris

final class SwissEphemerisTests: XCTestCase {
	
	override func setUpWithError() throws {
		JPLFileManager.setEphemerisPath()
	}

    func testSunZodiacCoordinate() {
        // 12.14.2019 13:39 UT/GMT
        let date = Date(timeIntervalSince1970: 598023482.487818)
        let sunCoordinate = Coordinate<Planet>(body: .sun, date: date)
        XCTAssertEqual(sunCoordinate.value, 261.7804948994796)
        XCTAssertEqual(sunCoordinate.sign, .sagittarius)
        XCTAssertEqual(sunCoordinate.formatted, "21 Degrees Sagittarius ♐︎ 46' 49''")
		XCTAssertEqual(Int(sunCoordinate.degree), 21)
        XCTAssertEqual(Int(sunCoordinate.minute), 46)
        XCTAssertEqual(Int(sunCoordinate.second), 49)
    }
	
	func testAstroids() throws {
		let timestamp = "2021-03-01T12:31:00-0800"
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let date = try XCTUnwrap(dateFormatter.date(from:timestamp))
		let chiron = Coordinate<Astroid>(body: .chiron, date: date)
		XCTAssertEqual(Int(chiron.degree), 7)
		XCTAssertEqual(chiron.sign, .aries)
		let pholus = Coordinate<Astroid>(body: .pholus, date: date)
		XCTAssertEqual(Int(pholus.degree), 5)
		XCTAssertEqual(pholus.sign, .capricorn)
		let ceres = Coordinate<Astroid>(body: .ceres, date: date)
		XCTAssertEqual(Int(ceres.degree), 3)
		XCTAssertEqual(ceres.sign, .aries)
		let pallas = Coordinate<Astroid>(body: .pallas, date: date)
		XCTAssertEqual(Int(pallas.degree), 28)
		XCTAssertEqual(pallas.sign, .aquarius)
		let juno = Coordinate<Astroid>(body: .juno, date: date)
		XCTAssertEqual(Int(juno.degree), 19)
		XCTAssertEqual(juno.sign, .sagittarius)
		let vesta = Coordinate<Astroid>(body: .vesta, date: date)
		XCTAssertEqual(Int(vesta.degree), 15)
		XCTAssertEqual(vesta.sign, .virgo)
	}
	
	func testLunarNodes() throws {
		let date = try XCTUnwrap(Mock.date(year: 2121, month: 1, day: 1, hour: 1, minute: 1, second: 1))
		let trueNode = Coordinate<LunarNode>(body: .trueNode, date: date)
		XCTAssertEqual(Int(trueNode.degree), 3)
		XCTAssertEqual(trueNode.sign, .aquarius)
		let meanNode = Coordinate<LunarNode>(body: .meanNode, date: date)
		XCTAssertEqual(Int(meanNode.degree), 4)
		XCTAssertEqual(meanNode.sign, .aquarius)
	}
    
    func testPlanets() {
        for (index, planet) in Planet.allCases.enumerated() {
            switch index {
            case 0:
                XCTAssertEqual(planet.formatted, "☉ Sun")
				XCTAssertEqual(planet.symbol, "☉")
            case 1:
                XCTAssertEqual(planet.formatted, "☾ Moon")
				XCTAssertEqual(planet.symbol, "☾")
            case 2:
                XCTAssertEqual(planet.formatted, "☿ Mercury")
				XCTAssertEqual(planet.symbol, "☿")
            case 3:
                XCTAssertEqual(planet.formatted, "♀ Venus")
				XCTAssertEqual(planet.symbol, "♀")
            case 4:
                XCTAssertEqual(planet.formatted, "♂️Mars")
				XCTAssertEqual(planet.symbol, "♂︎")
            case 5:
                XCTAssertEqual(planet.formatted, "♃ Jupiter")
				XCTAssertEqual(planet.symbol, "♃")
            case 6:
                XCTAssertEqual(planet.formatted, "♄ Saturn")
				XCTAssertEqual(planet.symbol, "♄")
            case 7:
                XCTAssertEqual(planet.formatted, "♅ Uranus")
				XCTAssertEqual(planet.symbol, "♅")
            case 8:
                XCTAssertEqual(planet.formatted, "♆ Neptune")
				XCTAssertEqual(planet.symbol, "♆")
            case 9:
                XCTAssertEqual(planet.formatted, "♇ Pluto")
				XCTAssertEqual(planet.symbol, "♇")
            default:
                XCTFail("Failed because there are planets that not tested")
            }
        }
    }
    
    func testZodiac() {
        for (index, sign) in Zodiac.allCases.enumerated() {
            switch index {
            case 0:
                XCTAssertEqual(sign.formatted, "Aries ♈︎")
				XCTAssertEqual(sign.symbol, "♈︎")
            case 1:
                XCTAssertEqual(sign.formatted, "Taurus ♉︎")
				XCTAssertEqual(sign.symbol, "♉︎")
            case 2:
                XCTAssertEqual(sign.formatted, "Gemini ♊︎")
				XCTAssertEqual(sign.symbol, "♊︎")
            case 3:
                XCTAssertEqual(sign.formatted, "Cancer ♋︎")
				XCTAssertEqual(sign.symbol, "♋︎")
            case 4:
                XCTAssertEqual(sign.formatted, "Leo ♌︎")
				XCTAssertEqual(sign.symbol, "♌︎")
            case 5:
                XCTAssertEqual(sign.formatted, "Virgo ♍︎")
				XCTAssertEqual(sign.symbol, "♍︎")
            case 6:
                XCTAssertEqual(sign.formatted, "Libra ♎︎")
				XCTAssertEqual(sign.symbol, "♎︎")
            case 7:
                XCTAssertEqual(sign.formatted, "Scorpio ♏︎")
				XCTAssertEqual(sign.symbol, "♏︎")
            case 8:
                XCTAssertEqual(sign.formatted, "Sagittarius ♐︎")
				XCTAssertEqual(sign.symbol, "♐︎")
            case 9:
                XCTAssertEqual(sign.formatted, "Capricorn ♑︎")
				XCTAssertEqual(sign.symbol, "♑︎")
            case 10:
                XCTAssertEqual(sign.formatted, "Aquarius ♒︎")
				XCTAssertEqual(sign.symbol, "♒︎")
            case 11:
                XCTAssertEqual(sign.formatted, "Pisces ♓︎")
				XCTAssertEqual(sign.symbol, "♓︎")
            default:
                XCTFail("Failed because there are signs that are not tested")
            }
        }
        XCTAssertNil(Zodiac(rawValue: 12))
    }

    func testAscendent() {
        let houseSystem = Mock.makeHouses()
        // Ascendent
        let ascCoordinate = houseSystem.ascendent
        XCTAssertEqual(ascCoordinate.sign, Zodiac.sagittarius)
        XCTAssertEqual(ascCoordinate.formatted, "2 Degrees Sagittarius ♐︎ 1' 49''")
        // MC
        let mc = houseSystem.midHeaven
        XCTAssertEqual(mc.sign, Zodiac.virgo)
    }
    
    func testHouses() {
        let houseSystem = Mock.makeHouses()
        /// House Cusps
        XCTAssertEqual(houseSystem.first.sign, Zodiac.sagittarius)
        XCTAssertEqual(houseSystem.second.sign, Zodiac.capricorn)
        XCTAssertEqual(houseSystem.third.sign, Zodiac.aquarius)
        XCTAssertEqual(houseSystem.fourth.sign, Zodiac.pisces)
        XCTAssertEqual(houseSystem.fifth.sign, Zodiac.aries)
        XCTAssertEqual(houseSystem.sixth.sign, Zodiac.taurus)
        XCTAssertEqual(houseSystem.seventh.sign, Zodiac.gemini)
        XCTAssertEqual(houseSystem.eighth.sign, Zodiac.cancer)
        XCTAssertEqual(houseSystem.ninth.sign, Zodiac.leo)
		XCTAssertEqual(houseSystem.tenth.sign, Zodiac.virgo)
        XCTAssertEqual(houseSystem.eleventh.sign, Zodiac.libra)
        XCTAssertEqual(houseSystem.twelfth.sign, Zodiac.scorpio)
    }
    
    func testAspects() {
        // Expect 64.0 relationship sextile
		var aspect = Aspect(pair: Pair<Planet, Planet>(a: .jupiter, b: .moon), date: Mock.date, orb: 8.0)
		XCTAssertEqual(aspect?.remainder, 3.45)
        XCTAssertEqual(aspect, .sextile(3.45))
        XCTAssertEqual(aspect?.symbol, "﹡")
        // Expect reverse to be 64.0 sextile
		aspect = Aspect(pair: Pair<Planet, Planet>(a: .moon, b: .jupiter), date: Mock.date, orb: 8.0)
        XCTAssertEqual(aspect?.remainder, 3.45)
        XCTAssertEqual(aspect, .sextile(3.45))
        // Expect 3.0 relationship conjunction
		aspect = Aspect(pair: Pair<Planet, Planet>(a: .sun, b: .pluto), date: Mock.date, orb: 8.0)
        XCTAssertEqual(aspect?.remainder, 3.05)
        XCTAssertEqual(aspect, .conjunction(3.05))
        XCTAssertEqual(aspect?.symbol, "☌")
        // Expect 171.0 relationship opposition
		aspect = Aspect(pair: Pair<Planet, Planet>(a: .mars, b: .jupiter), date: Mock.date, orb: 10)
        XCTAssertEqual(aspect?.remainder, -8.96)
        XCTAssertEqual(aspect, .opposition(-8.96))
        XCTAssertEqual(aspect?.symbol, "☍")
        // Expect 124.0 relationship trine
		aspect = Aspect(pair: Pair<Planet, Planet>(a: .saturn, b: .jupiter), date: Mock.date, orb: 10)
        XCTAssertEqual(aspect?.remainder, 4.65)
        XCTAssertEqual(aspect, .trine(4.65))
        XCTAssertEqual(aspect?.symbol, "▵")
        // Expect 84.0 relationship square
		aspect = Aspect(pair: Pair<Planet, Planet>(a: .venus, b: .moon), date: Mock.date, orb: 10)
        XCTAssertEqual(aspect?.remainder, -5.07)
        XCTAssertEqual(aspect, .square(-5.07))
        XCTAssertEqual(aspect?.symbol, "◾️")
        // Expect no aspect
        XCTAssertNil(Aspect(pair: Pair<Planet, Planet>(a: .venus, b: .mars), date: Mock.date, orb: 5))
    }

	func testAspectCount() {
		let sunAspects = Planet.allCases.compactMap {
			Aspect(pair: Pair<Planet, Planet>(a: .sun, b: $0),date: Mock.date, orb: 10)
		}
		XCTAssertEqual(sunAspects.count, 4)
		let moonAspects = Planet.allCases.compactMap {
			Aspect(pair: Pair<Planet, Planet>(a: .moon, b: $0),date: Mock.date, orb: 10)
		}
		XCTAssertEqual(moonAspects.count, 7)
		let mercuryAspects = Planet.allCases.compactMap {
			Aspect(pair: Pair<Planet, Planet>(a: .mercury, b: $0),date: Mock.date, orb: 8)
		}
		XCTAssertEqual(mercuryAspects.count, 4)
	}
	
    func testPlanetsOnAscendent() {
        let houseSystem = Mock.makeHouses()
        let ascendent = houseSystem.ascendent
        let aspects = Planet.allCases.compactMap {
			Aspect(a: ascendent.value,
				   b: Coordinate<Planet>(body: $0, date: Mock.date).value,
				   orb: 10)
        }
        XCTAssertEqual(aspects.compactMap { $0 }.count, 1)
    }
    
    func testPlanetaryStation() {
        XCTAssertEqual(Station<Planet>(coordinate: Coordinate(body: .sun, date: Mock.date)), .direct)
        XCTAssertEqual(Station<Planet>(coordinate: Coordinate(body: .mars, date: Mock.date)), .direct)
        XCTAssertEqual(Station<Planet>(coordinate: Coordinate(body: .mercury, date: Mock.date)), .retrograde)
        XCTAssertEqual(Station<Planet>(coordinate: Coordinate(body: .jupiter, date: Mock.date)), .retrograde)
    }
    
    func testSpringEquinoxPerformance() {
        measure {
            var coordinate = Coordinate<Planet>(body: .sun, date: Date())
            while coordinate.value > 1.0 {
                coordinate = Coordinate(body: .sun, date: coordinate.date.addingTimeInterval(60 * 60 * 12))
            }
        }
    }
	
    func testAutumnalEquinoxPerformance() {
        measure {
            var coordinate = Coordinate<Planet>(body: .sun, date: Date())
            while Int(coordinate.value) != 180 {
                coordinate = Coordinate(body: .sun, date: coordinate.date.addingTimeInterval(60 * 60 * 12))
            }
        }
    }

	func testTransit() {
		XCTAssertNil(Transit(pair: Pair<Planet, Planet>(a: .jupiter, b: .sun), date: Mock.date, orb: 2))
		measure {
			let transit = Transit(pair: Pair<Planet, Planet>(a: .jupiter, b: .saturn), date: Mock.date, orb: 10)
			if let transit = transit {
				debugPrint("Start Date: \(transit.start) End Date: \(transit.end)")
			}
		}
	}

	static var allTests = [
		("testSunZodiacCoordinate",testSunZodiacCoordinate,
		 "testPlanets", testPlanets,
		 "testAstroids", testAstroids,
		 "testZodiac", testZodiac,
		 "testLunarNodes", testLunarNodes,
		 "testAscendent", testAscendent,
		 "testHouses", testHouses,
		 "testAspects", testAspects,
		 "testPlanetaryStation", testPlanetaryStation,
		 "testSpringEquinoxPerformance", testSpringEquinoxPerformance,
		 "testAutumnalEquinoxPerformance", testAutumnalEquinoxPerformance,
		 "testTransit", testTransit)
	]
}
