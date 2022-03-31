//
//  Saving.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-31.
//

import Foundation

struct Saving: Persistable {
    var createdAt: String
    var icon: String
    var type: CalculationType
    var principleAmount: Double
    var interestRate: Double
    var monthlyPay: Double
    var futureValue: Double
    var numOfPayments: Double

    init(icon: String,
         type: CalculationType,
         principleAmount: Double,
         interestRate: Double, 
         monthlyPay: Double, 
         futureValue: Double, 
         numOfPayments: Double) {
        self.icon = icon
        self.type = type
        self.principleAmount = principleAmount
        self.interestRate = interestRate
        self.monthlyPay = monthlyPay
        self.numOfPayments = numOfPayments
        self.futureValue = futureValue
        self.createdAt = "\(Date())"
    }
}
