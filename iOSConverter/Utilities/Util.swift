//
//  Util.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-05.
//

import Foundation

final class Util {

    static let shared: Util = Util()

    private init() {

    }

    func validateNegative(_ forString: String) -> String {
        if forString.contains("-") {
            return forString
        }

//        forString += "
        return ""
    }

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

    func includeZeroIfNeeded(_ forString: String) -> String {
        var string = forString
        if forString.count == 1 && forString.first == "0"{
            return forString
        }
        string += "0"
        return string
    }

    func calculateLoanInterest(amount: Double??, monthlyPay: Double?, terms: Double?) -> Double? {
        let precision = UserDefaults.standard.integer(forKey: K.Keys.Precision)

        return 0
    }
}
