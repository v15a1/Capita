//
//  ItemManageable.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-04-07.
//

import Foundation

/// Properties & functions conforming manager classes need to implement
/// `T` is a generic parameter for allowing generalization
protocol ItemManageable {
    associatedtype T
    
    var item: T! { get set } // Item to store data/calculations
    var isShowingYears: Bool { get set } // For displaying/calculating based no years
    
    func appendHistory()
}
