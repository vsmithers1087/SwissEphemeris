//
//  BatchRequest.swift
//  
//
//  Created by Vincent on 6/28/21.
//

import Foundation

/// Models a request for batch calculations at a consistent
/// date interval. If you are making hundreds of calculations at one time
/// it is recommended to use these utility methods for increased performance
/// and to avoid the undefined behavior that results from making numerous calculations
/// concurrently on a single thread.
public protocol BatchRequest {
    /// The type returned from the fetch request.
    associatedtype EphemerisItem
    /// The maximum amount of concurrent calculations. Exceed `478` at your own risk.
    var datesThreshold: Int { get }
    
    /// Fetches all of the `RequestType`s  between two dates.
    /// - Parameters:
    ///   - start: The starting date.
    ///   - end: The ending date.
    ///   - interval:The time interval in which the `RequestType` is created between the `start` and `end` dates.
    ///   - closure: The asynchronous collection of `EphemerisItem`.
    func fetch(start: Date, end: Date, interval: TimeInterval, _ closure: ([EphemerisItem]) -> Void)
}

// MARK: - Helper Methods

extension BatchRequest {
    
    /// Helper method that prepares a collection of dates so that they can be mapped to the `EphemerisItem`.
    /// - Parameters:
    ///   - start: The starting date.
    ///   - end: The ending date.
    ///   - interval: The time interval in which the `Date` is created between the `start` and `end` dates.
    /// - Returns: A 2D array of dates with each subarray containing a count of dates equal to the `datesThreshold`, or less in the case that the dates are a remainder.
    func dates(for start: Date, end: Date, interval: TimeInterval) -> [[Date]] {
        var dates = [[Date]]()
        for (index, date) in stride(from: start, to: end, by: interval).enumerated() {
            if index % datesThreshold == 0 {
                dates.append([date])
            } else {
                dates[dates.count - 1].append(date)
            }
        }
        return dates
    }
}
