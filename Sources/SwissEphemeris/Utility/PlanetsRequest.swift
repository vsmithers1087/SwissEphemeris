//
//  PlanetsRequest.swift
//  
//
//  Created by Vincent on 6/29/21.
//

import Foundation

/// A `BatchRequest` for a collection of `Planet` `Coordinates`.
final public class PlanetsRequest: BatchRequest {
    
    /// The `Planet` to request.
    private let body: Planet
    public typealias EphemerisItem = Coordinate<Planet>
    public let datesThreshold = 478
    
    /// Creates an instance of `PlanetsRequest`.
    /// - Parameter body: The planet to request.
    public init(body: Planet) {
        self.body = body
    }
    
    public func fetch(start: Date, end: Date, interval: TimeInterval = 60.0, _ closure: ([EphemerisItem]) -> Void) {
        var coordinates = [EphemerisItem]()
        let group = DispatchGroup()
        func execute(batches: [[Date]], _ closure: ([EphemerisItem]) -> Void) {
            guard let batch = batches.first else {
                closure(coordinates)
                return
            }
            group.enter()
            let c = batch.map { EphemerisItem(body: body, date: $0) }
            coordinates.append(contentsOf: c)
            group.leave()
            execute(batches: Array(batches.dropFirst()), closure)
        }
        execute(batches: dates(for: start, end: end, interval: interval), closure)
    }
}
