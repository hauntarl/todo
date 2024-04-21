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
    private static var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    var formatted: String {
        Self.dateFormatter.string(from: self)
    }
}
