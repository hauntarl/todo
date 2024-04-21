//
//  Date+Extension.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//

import Foundation

/**
 Extension on Date defines a custom date formatter
 */
extension Date {
    /// Outputs date in `"April 21, 2024"` format
    var formatted: String {
        Self.dateFormatter.string(from: self)
    }

    /// Creates a new date from given input using the `dateParser`
    static func from(_ input: String) -> Self? {
        Self.dateParser.date(from: input)
    }
    
    /// Converts the date into `ISO6801` format, including micro-seconds
    var iso8601: String {
        ISO8601Format(.iso8601WithTimeZone(includingFractionalSeconds: true))
    }
    
    private static var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    private static var dateParser: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ"
        formatter.locale = .init(identifier: "UTC")
        return formatter
    }()
}
