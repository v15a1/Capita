//
//  Util.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-05.
//

import Foundation

/// Singleton `Util` class
final class Util {

    static let shared: Util = Util()

    private init() {}
    
    /// Applies negative/dash sign if necessary
    /// - Parameter forString: String to check negation for
    /// - Returns: new string
    func validateNegative(_ forString: String) -> String {
        if forString.contains("-") {
            return forString
        } else if forString.isEmpty {
            return "-"
        }
        return forString
    }
    
    /// Applies decimal point if needed
    /// - Parameter forString: String to add decimal to
    /// - Returns: String with/witout the decimal point
    func applyDecimalIfNeeded( _ forString: String) -> String {
        let containsDecimal = !forString.contains(".")
        let length = forString.count > 0
        if containsDecimal && length {
            var decimalString = forString
            decimalString += "."
            return decimalString
        }
        return forString
    }
    
    /// Prevents user from enterring multiple zeros at the start
    /// - Parameter forString: String to add zero if needed
    /// - Returns: String with/without a zero
    func includeZeroIfNeeded(_ forString: String) -> String {
        var string = forString
        if forString.count == 1 && forString.first == "0"{
            return forString
        }
        string += "0"
        return string
    }
}
