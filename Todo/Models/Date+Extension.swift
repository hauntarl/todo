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
    /// Create a default date
    static var defaultDate = Self(timeIntervalSince1970: .zero)
    
    /// Creates a new date from given input using custom date parsers
    static func from(_ input: String) -> Self? {
        Self.dateParserWithFractionalSeconds.date(from: input) ?? Self.dateParser.date(from: input)
    }

    /// Outputs date in `"April 21, 2024"` format
    var formatted: String {
        Self.dateFormatter.string(from: self)
    }

    /// Converts the date into `ISO8601` format, including micro-seconds
    var iso8601: String {
        ISO8601Format(.iso8601WithTimeZone(includingFractionalSeconds: true))
    }
    
    private static var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    private static var dateParserWithFractionalSeconds: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = .gmt
        return formatter
    }()
    
    private static var dateParser: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = .gmt
        return formatter
    }()
}
