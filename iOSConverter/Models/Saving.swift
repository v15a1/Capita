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
    var type: CalculationType = .saving
    var principleAmount: Double
    var interestRate: Double
    var compound: Double = 12
    var futureValue: Double
    var numOfPayments: Double

    init(icon: String,
         principleAmount: Double,
         interestRate: Double, 
         futureValue: Double, 
         numOfPayments: Double) {
        self.icon = icon
        self.principleAmount = principleAmount
        self.interestRate = interestRate
        self.numOfPayments = numOfPayments
        self.futureValue = futureValue
        self.createdAt = "\(Date())"
    }
}
