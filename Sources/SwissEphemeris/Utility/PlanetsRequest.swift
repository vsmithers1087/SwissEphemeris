//
//  PlanetsRequest.swift
//  
//
//  Created by Vincent on 6/29/21.
//

import Foundation

///
final class PlanetsRequest: BatchRequest {
    
    private let body: Planet
    typealias RequestItem = Coordinate<Planet>
    let datesThreshold = 478
    
    /// <#Description#>
    /// - Parameter body: <#body description#>
    init(body: Planet) {
        self.body = body
    }
    
    func fetch(start: Date, end: Date, _ closure: ([RequestItem]) -> Void) {
        var coordinates = [RequestItem]()
        let group = DispatchGroup()
        func execute(batches: [[Date]], _ closure: ([RequestItem]) -> Void) {
            guard let batch = batches.first else {
                closure(coordinates)
                return
            }
            group.enter()
            let c = batch.map { RequestItem(body: body, date: $0) }
            coordinates.append(contentsOf: c)
            group.leave()
            execute(batches: Array(batches.dropFirst()), closure)
        }
        execute(batches: dates(for: start, end: end), closure)
    }
}
