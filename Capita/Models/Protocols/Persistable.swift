//
//  Persistable.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-20.
//

import Foundation
import UIKit

enum CalculationType: Int, Codable {
    case compoundSaving
    case simpleSaving
    case loan
}

protocol Persistable: Codable {
    var type: CalculationType { get }
    var createdAt: String { get }
}

extension Persistable {
    func toDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd \t HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: self.createdAt)!

        dateFormatter.dateFormat = "HH:mm\tdd/MM/yyyy"
        return dateFormatter.string(from: date)
    }

    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
        return dateFormatter.date(from: self.createdAt)!
    }
}
