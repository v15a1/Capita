//
//  ItemManageable.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-04-07.
//

import Foundation

protocol ItemManageable {
    associatedtype T
    var item: T! { get set }
    var isShowingYears: Bool { get set }
    
    func appendHistory()
}
