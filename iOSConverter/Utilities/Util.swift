//
//  Util.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-05.
//

import Foundation

final class Util {

    let shared: Util = Util()

    private init() {

    }

    func validateNegative(_ forString: String) -> String {
        if forString.contains("-") {
            return forString
        }

//        forString += "
        return ""
    }

    func validateDecimals(_ forString: String) -> Bool{
        return forString.contains(".")
    }

    func letZeroDigit(_ forString: String) -> Bool {
//        if forString.count >= 1 {
//            let starterDigitCheck = forString.first == "0" && forString.contains(".")
//            return starterDigitCheck ? true : false
//        }
        return false
    }
}
