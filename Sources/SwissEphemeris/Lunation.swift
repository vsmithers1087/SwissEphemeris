//
//  Lunation.swift
//  
//
//  Created by Vincent Smithers on 18.03.21.
//

import Foundation

import CSwissEphemeris

/// Models the momentary state of a current lunar phase.
public struct Lunation {
	
	/// Represents common phases of the moon.
	public enum Phase: Int {
		/// Less than one percent full.
		case new
		/// 1 to 50 percent towards full.
		case waxingCrescent
		/// 50 to 98 percent towards full.
		case waxingGibbous
		/// 98 to 100 percent full.
		case full
		/// 98 to 50 percent towards new.
		case waningGibbous
		/// 50 to 1 percent towards new.
		case waningCrescent
		
		/// Creates a lunar phase.
		/// - Parameter lunation: The `Lunation` for the phase.
		init(lunation: Lunation) {
			switch lunation.percentage {
			case 0.01...0.50:
				self = lunation.isWaxing ? .waxingCrescent : .waningCrescent
			case 0.50...0.98:
				self = lunation.isWaxing ? .waxingGibbous : .waningGibbous
			case 0.98...1.00:
				self = .full
			default:
				self = .new
			}
		}
	}
	
	/// https://en.wikipedia.org/wiki/Lunar_phase
	/// An estimation on the number days in a lunar cycle.
	public static let daysInLunation: Double = 29.530588
	/// The exact date for the lunation time.
	public let date: Date
	/// The percentage full.
	public let percentage: Double
	/// Lunation is moving towards full
	let isWaxing: Bool
	/// The current `Phase`.
	public var phase: Phase { Phase(lunation: self) }
	/// The pointer that holds all values.
	private let pointerPresent = UnsafeMutablePointer<Double>.allocate(capacity: 20)
	/// The pointer holds the percentage for the previous hour. This is used to know if the cycle is waxing or waning.
	private let pointerFuture = UnsafeMutablePointer<Double>.allocate(capacity: 20)

	/// Creates a `Lunation`.
	/// - Parameter date: The exact date for the lunation time.
	public init(date: Date) {
		self.date = date
		swe_pheno_ut(date.julianDate(),
					 Planet.moon.rawValue,
					 SEFLG_SPEED,
					 pointerPresent,
					 nil)
		swe_pheno_ut(date.addingTimeInterval(-60 * 60).julianDate(),
					 Planet.moon.rawValue,
					 SEFLG_SPEED,
					 pointerFuture,
					 nil)
		percentage = pointerPresent[1]
		isWaxing = percentage > pointerFuture[1]
	}
}
