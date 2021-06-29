//
//  LunationsRequest.swift
//  
//
//  Created by Vincent on 6/29/21.
//

import Foundation

/// A `BatchRequest` for a collection of `Lunation`.
final class LunationsRequest: BatchRequest {
    
    typealias RequestItem = Lunation
    let datesThreshold = 478
    
    func fetch(start: Date, end: Date, _ closure: ([RequestItem]) -> Void) {
        var lunations = [Lunation]()
        let group = DispatchGroup()
        func execute(batches: [[Date]], _ closure: ([Lunation]) -> Void) {
            guard let batch = batches.first else {
                closure(lunations)
                return
            }
            group.enter()
            let c = batch.map { Lunation(date: $0) }
            lunations.append(contentsOf: c)
            group.leave()
            execute(batches: Array(batches.dropFirst()), closure)
        }
        execute(batches: dates(for: start, end: end), closure)
    }
}
