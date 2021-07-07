//
//  LunationsRequest.swift
//  
//
//  Created by Vincent on 6/29/21.
//

import Foundation

/// A `BatchRequest` for a collection of `Lunation`.
final public class LunationsRequest: BatchRequest {
    
    public typealias EphemerisItem = Lunation
    public let datesThreshold = 478
    
    /// Creates an instance of `LunationsRequest`.
    public init() {}
    
    public func fetch(start: Date, end: Date, interval: TimeInterval = 60.0, _ closure: ([EphemerisItem]) -> Void) {
        var lunations = [EphemerisItem]()
        let group = DispatchGroup()
        func execute(batches: [[Date]], _ closure: ([EphemerisItem]) -> Void) {
            guard let batch = batches.first else {
                closure(lunations)
                return
            }
            group.enter()
            let c = batch.map { EphemerisItem(date: $0) }
            lunations.append(contentsOf: c)
            group.leave()
            execute(batches: Array(batches.dropFirst()), closure)
        }
        execute(batches: dates(for: start, end: end, interval: interval), closure)
    }
}
