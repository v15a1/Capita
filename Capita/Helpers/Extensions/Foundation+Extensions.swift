//
//  Foundation+Extensions.swift
//  Capita
//
//  Created by Visal Rajapakse on 2022-04-09.
//

import Foundation

// MARK: Double Extensions
extension Double {
    /// Fixes double values to a provided number of decimal places
    /// - Parameter places: Number of decimal places
    /// - Returns: Double fixed to a certain number of decimal places
    func fixedTo(_ places: Int) -> Double {
        let divisor: Double = pow(10, Double(places))
        return (divisor * self).rounded() / divisor
    }
}

// MARK: Array<LabelledTextField> Extensions
extension Array where Element: LabelledTextfield {
    
    /// Iterates all the `LabelledTextfields` to see if it's valid to save the data
    var isSavable : Bool {
        get {
            let compacted = self.compactMap{ ($0.text?.isEmpty)! ? nil : $0 }
            return compacted.count >= self.endIndex
        }
    }
    
    /// Finds `LabelledTextfield` by tag
    /// - Parameter tag: Identifier to find
    /// - Returns: identified `LabelledTextfield`
    func by(tag: Int) -> LabelledTextfield {
        return self.first(where: { $0.tag == tag})!
    }

    func valueByTag(tag: Int) -> Double? {
        if let element = self.first(where: { $0.tag == tag}) {
            return Double(element.inputTextfield.text!)
        }
        return nil
    }
    
    /// Finds the `LabelledTextfield` with empty text
    /// - Parameter excludingTag: Excludes `LabelledTextfields` with matching identifier
    /// - Returns: Empty `LabelledTextfield`
    mutating func getEmpty(_ excludingTag: Int? = nil) -> LabelledTextfield? {
        if let tag = excludingTag {
            self.removeAll { $0.tag == tag }
        }
        if let tf = self.first(where: { $0.text?.isEmpty  == true }) {
            return tf
        }
        return nil
    }
    
    /// Sets text to a `LabelledTextfield`
    /// - Parameters:
    ///   - text: String to set
    ///   - forTag: identifier to set the text to
    func setText(_ text: String, forTag: Int) {
        if let element = self.first(where: { $0.tag == forTag}) {
            element.text = text
        }
    }
}
