//
//  Util.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-05.
//

import Foundation

final class Util {

    static let shared: Util = Util()

    var precision: Int {
        return UserDefaults.standard.integer(forKey: K.Keys.Precision)
    }

    private init() {

    }

    func validateNegative(_ forString: String) -> String {
        if forString.contains("-") {
            return forString
        }
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

    func calculateLoanInterest(amount: Double, monthlyPay: Double, terms: Double) -> Double? {
//        let precision = UserDefaults.standard.integer(forKey: K.Keys.Precision)
//        let rate: Double = (interest / 100.0) / 12
        return 0
    }

    func calculateLoanPrincipalAmount(interest: Double, monthlyPay: Double, terms: Double) -> Double {
        let interestPerMonth: Double = (interest / 100) / 12
        let amount: Double = (monthlyPay / interestPerMonth) * (1 - (1 / pow(1 + interestPerMonth, terms)))
        return amount.fixedTo(2)
    }

    func calculateLoanMonthlyPay(amount: Double, interest: Double, terms: Double) -> Double {
        let rate: Double = (interest / 100) / 12
        let numerator = (rate * amount)
        let denomenator = (1 - pow(1 + rate, -terms))
        return (numerator / denomenator).fixedTo(2)
    }

    func calculateLoanTerms(amount: Double, interest: Double, monthlyPay: Double) -> Double? {
        var minMonthlyPay = calculateLoanMonthlyPay(amount: amount, interest: interest, terms: 1) - amount
        minMonthlyPay -= amount

        if Int(monthlyPay) <= Int(minMonthlyPay) {
            return nil
        }

        let interestPerMonth: Double = (interest / 100) / 12
        let mPayForInterest: Double = monthlyPay / interestPerMonth
        let terms = (log(mPayForInterest / (mPayForInterest - amount)) / log(1 + interestPerMonth))
        return terms
    }
}
