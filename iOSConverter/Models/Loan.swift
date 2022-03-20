//
//  Loan.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-20.
//

import Foundation

struct Loan: Persistable {
    var id: UUID = UUID()
    var createdAt: Date! = Date()
    var icon: String!
    var type: CalculationType!

    var principleAmount: Double!
    var interestRate: Double!
    var monthlyPay: Double!
    var numOfPayments: Double!
}
