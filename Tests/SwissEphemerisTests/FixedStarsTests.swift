import XCTest
@testable import SwissEphemeris

final class FixedStarsTests: XCTestCase {
	
	override func setUpWithError() throws {
		JPLFileManager.setEphemerisPath()
	}
	
	func testGalacticCenter() {
		let galacticCenter = Coordinate<FixedStar>(body: .galacticCenter, date: Mock.date)
		XCTAssertEqual(galacticCenter.formatted, "26 Degrees Sagittarius ♐︎ 40' 39''")
	}
	
	func testAldebaran() {
		let aldebaran = Coordinate<FixedStar>(body: .aldebaran, date: Mock.date)
		XCTAssertEqual(aldebaran.formatted, "9 Degrees Gemini ♊︎ 37' 24''")
	}
	
	func testAntares() {
		let antares = Coordinate<FixedStar>(body: .antares, date: Mock.date)
		XCTAssertEqual(antares.formatted, "9 Degrees Sagittarius ♐︎ 35' 13''")
	}
	
	func testRegulus() {
		let regulus = Coordinate<FixedStar>(body: .regulus, date: Mock.date)
		XCTAssertEqual(regulus.formatted, "29 Degrees Leo ♌︎ 39' 26''")
	}
	
	func testSirius() {
		let sirius = Coordinate<FixedStar>(body: .sirius, date: Mock.date)
		XCTAssertEqual(sirius.formatted, "13 Degrees Cancer ♋︎ 55' 0''")
	}
	
	func testSpica() {
		let spica = Coordinate<FixedStar>(body: .spica, date: Mock.date)
		XCTAssertEqual(spica.formatted, "23 Degrees Libra ♎︎ 39' 56''")
	}
	
	func testAlgol() {
		let algol = Coordinate<FixedStar>(body: .algol, date: Mock.date)
		XCTAssertEqual(algol.formatted, "26 Degrees Taurus ♉︎ 0' 12''")
	}
	
	func testRigel() {
		let rigel = Coordinate<FixedStar>(body: .rigel, date: Mock.date)
		XCTAssertEqual(rigel.formatted, "16 Degrees Gemini ♊︎ 39' 51''")
	}
	
	func testAltair() {
		let altair = Coordinate<FixedStar>(body: .altair, date: Mock.date)
		XCTAssertEqual(altair.formatted, "1 Degrees Aquarius ♒︎ 36' 12''")
	}
	
	func testCapella() {
		let capella = Coordinate<FixedStar>(body: .capella, date: Mock.date)
		XCTAssertEqual(capella.formatted, "21 Degrees Gemini ♊︎ 41' 30''")
	}
	
	func testArcturus() {
		let arcturus = Coordinate<FixedStar>(body: .arcturus, date: Mock.date)
		XCTAssertEqual(arcturus.formatted, "24 Degrees Libra ♎︎ 3' 24''")
	}
	
	func testProcyon() {
		let procyon = Coordinate<FixedStar>(body: .procyon, date: Mock.date)
		XCTAssertEqual(procyon.formatted, "25 Degrees Cancer ♋︎ 37' 6''")
	}
	
	func testCastor() {
		let castor = Coordinate<FixedStar>(body: .castor, date: Mock.date)
		XCTAssertEqual(castor.formatted, "20 Degrees Cancer ♋︎ 4' 19''")
	}
	
	func testPollux() {
		let pollux = Coordinate<FixedStar>(body: .pollux, date: Mock.date)
		XCTAssertEqual(pollux.formatted, "23 Degrees Cancer ♋︎ 2' 55''")
	}
	
	func testBetelgeuse() {
		let betelgeuse = Coordinate<FixedStar>(body: .betelgeuse, date: Mock.date)
		XCTAssertEqual(betelgeuse.formatted, "28 Degrees Gemini ♊︎ 35' 16''")
	}
  
	static var allTests = [
		("testBetelgeuse",testBetelgeuse,
		 "testPollux", testPollux,
		 "testCastor", testCastor,
		 "testProcyon", testProcyon,
		 "testArcturus", testArcturus,
		 "testCapella", testCapella,
		 "testAltair", testAltair,
		 "testRigel", testRigel,
		 "testAlgol", testAlgol,
		 "testSpica", testSpica,
		 "testSirius", testSirius,
		 "testRegulus", testRegulus,
		 "testAntares", testAntares,
		 "testAldebaran", testAldebaran,
		 "testGalacticCenter", testGalacticCenter)
	]
}
