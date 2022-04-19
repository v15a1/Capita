//
//  Persistable.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-20.
//

import Foundation
import UIKit

/// Type of the data persisted
/// Used for filtering the data in the history page
enum CalculationType: Int, Codable {
    case compoundSaving
    case simpleSaving
    case loan
}

/// Properties all conforming objects need to implement
protocol Persistable: Codable {
    var type: CalculationType { get }
    var createdAt: String { get }
}


extension Persistable {
    /// Converts a date object to a formatted string
    /// - Returns: A String formatted
    func toDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd \t HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: self.createdAt)!

        dateFormatter.dateFormat = "HH:mm\tdd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    /// Converts string to date
    /// - Returns: Converted date
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
        return dateFormatter.date(from: self.createdAt)!
    }
}
