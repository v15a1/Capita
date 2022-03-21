//
//  Loan.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-20.
//

import Foundation

struct Loan: Persistable {
    var createdAt: String
    var icon: String
    var type: CalculationType
    var principleAmount: Double
    var interestRate: Double
    var monthlyPay: Double
    var numOfPayments: Double

    init(icon: String, type: CalculationType, principleAmount: Double, interestRate: Double, monthlyPay: Double, numOfPayments: Double) {
        self.icon = icon
        self.type = type
        self.principleAmount = principleAmount
        self.interestRate = interestRate
        self.monthlyPay = monthlyPay
        self.numOfPayments = numOfPayments
        self.createdAt = "\(Date())"
    }
}
