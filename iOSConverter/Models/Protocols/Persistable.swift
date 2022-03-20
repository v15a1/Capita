//
//  Persistable.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-20.
//

import Foundation
import UIKit

enum CalculationType: Int, Codable {
    case saving
    case mortgage
    case loan
}

protocol Persistable: Codable, Identifiable {
    var id: UUID { get }
    var type: CalculationType! { get }
    var icon: String! { get }
    var createdAt: Date! { get }
}
