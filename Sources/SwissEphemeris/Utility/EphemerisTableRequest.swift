//
//  EphemerisTableRequest.swift
//  
//
//  Created by Vincent on 7/9/21.
//

import Foundation

final public class EphemerisTableRequest: BatchRequest {
    
    public typealias EphemerisItem = EphemerisTable
    public let datesThreshold = 35
    
    /// Creates an instance of `LunationsRequest`.
    public init() {}
    
    public func fetch(start: Date, end: Date, interval: TimeInterval = 60.0, _ closure: ([EphemerisItem]) -> Void) {
        var pages = [EphemerisItem]()
        let group = DispatchGroup()
        func execute(batches: [[Date]], _ closure: ([EphemerisItem]) -> Void) {
            guard let batch = batches.first else {
                closure(pages)
                return
            }
            group.enter()
            let c = batch.map { EphemerisItem(date: $0) }
            pages.append(contentsOf: c)
            group.leave()
            execute(batches: Array(batches.dropFirst()), closure)
        }
        execute(batches: dates(for: start, end: end, interval: interval), closure)
    }
}
