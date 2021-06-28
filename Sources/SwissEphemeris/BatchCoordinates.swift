//
//  BatchCoordinates.swift
//  
//
//  Created by Vincent on 6/28/21.
//

import Foundation

final class BatchCoordinates {

    private static let datesThreshold = 478

    static func execute<T: CelestialBody>(for body: T, start: Date, end: Date, _ closure: ([Coordinate<T>]) -> Void) {
     
        var dates = [[Date]]()
        for (index, date) in stride(from: start, to: end, by: 60).enumerated() {
            if index % datesThreshold == 0 {
                dates.append([date])
            } else {
                dates[dates.count - 1].append(date)
            }
        }
    
        let group = DispatchGroup()
        var coordinates = [Coordinate<T>]()
        func execute(batches: [[Date]], _ closure: ([Coordinate<T>]) -> Void) {
            guard let batch = batches.first else {
                closure(coordinates)
                return
            }
            group.enter()
            let c = batch.map { Coordinate(body: body, date: $0) }
            coordinates.append(contentsOf: c)
            group.leave()
            execute(batches: Array(batches.dropFirst()), closure)
        }
        execute(batches: dates, closure)
    }
}
extension Date: Strideable {}
