//
//  Transit.swift
//  
//
//  12.10.20.
//

import Foundation

/// Calculates the start, end and approximate exact time of a planet aspect.
public struct Transit {
	
	let subject: PlanetCoordinate
	let object: PlanetCoordinate
	let orb: Double
	
	public var startDate: Date {
		edgeDate(isFuture: false)
	}
	
	public var endDate: Date {
		edgeDate(isFuture: true)
	}
	
	public var exactDate: Date {
		calculateExact()
	}
	
	public init(subject: PlanetCoordinate, object: PlanetCoordinate, orb: Double) {
		self.subject = subject
		self.object = object
		self.orb = orb
	}
	
	private func edgeDate(isFuture: Bool) -> Date {
		var date = subject.date
		var subject = self.subject
		var object = self.object
		var planetAspect: PlanetAspect? = PlanetAspect(subjectDegree: subject.degree,
													   objectDegree: object.degree,
													   orb: orb)
		let minute: TimeInterval = isFuture ? 60 : -60
		while planetAspect?.aspect != nil {
			date = date.addingTimeInterval(minute * 60)
			subject = PlanetCoordinate(planet: subject.planet, date: date)
			object = PlanetCoordinate(planet: object.planet, date: date)
			planetAspect = PlanetAspect(subjectDegree: subject.degree,
										objectDegree: object.degree,
										orb: orb)
		}
		return date
	}
	
	private func calculateExact() -> Date {
		var date = subject.date
		var subject = self.subject
		var object = self.object
		var planetAspect = PlanetAspect(subjectDegree: subject.degree,
										objectDegree: object.degree,
										orb: orb)
		let minute: TimeInterval = planetAspect.direction == .applying ? 60 : -60
		var remainder = abs(planetAspect.aspect?.remainder ?? 0)
		while remainder > 0.1  {
			date = date.addingTimeInterval(minute * 60)
			subject = PlanetCoordinate(planet: subject.planet, date: date)
			object = PlanetCoordinate(planet: object.planet, date: date)
			planetAspect = PlanetAspect(subjectDegree: subject.degree,
										objectDegree: object.degree,
										orb: orb)
			remainder = abs(planetAspect.aspect?.remainder ?? 0)
		}
		return date
	}
}
