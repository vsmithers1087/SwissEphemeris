//
//  TimeSpan.swift
//  
//
//  15.09.20.
//

import Foundation
///let date =  Date(timeIntervalSinceNow: (60 * 60) * Double(hour))

public struct TimeSpan {
    public let start: Date
    public let end: Date
    /// The time at which a new date is marked. Default is 24 hours.
    public let interval: TimeInterval
    public var dates = [Date]()
    
    public init(start: Date, end: Date, interval: TimeInterval = 60 * 60 * 24) {
        self.start = start
        self.end = end
        self.interval = interval
        setDates()
    }
    
    private mutating func setDates() {
        var date: Date = start
        while date < end {
            let intervalDate = date.addingTimeInterval(interval)
            dates.append(intervalDate)
            date = intervalDate
        }
    }
}
