//
//  BatchRequest.swift
//  
//
//  Created by Vincent on 6/28/21.
//

import Foundation

/// Models a request for batch calculations at a consistent
/// date interval.  If you are making hundreds of calculations at one time
/// it is recommended to use these utility methods for increased performance
/// and to avoid the undefined behavior that results from making many calculations
/// concurrently on a single thread.
protocol BatchRequest {
    /// The type returned from the fetch request.
    associatedtype RequestItem
    /// The maximum amount of concurrent calculations.
    var datesThreshold: Int { get }
    
    /// <#Description#>
    /// - Parameters:
    ///   - start: <#start description#>
    ///   - end: <#end description#>
    ///   - closure: <#closure description#>
    func fetch(start: Date, end: Date, _ closure: ([RequestItem]) -> Void)
}

// MARK: - Helper Methods

extension BatchRequest {
    
    func dates(for start: Date, end: Date) -> [[Date]] {
        var dates = [[Date]]()
        for (index, date) in stride(from: start, to: end, by: 60).enumerated() {
            if index % datesThreshold == 0 {
                dates.append([date])
            } else {
                dates[dates.count - 1].append(date)
            }
        }
        return dates
    }
}
