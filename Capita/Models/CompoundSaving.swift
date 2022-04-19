//
//  Saving.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-31.
//

import Foundation

struct CompoundSaving: Persistable {
    var createdAt: String
    var type: CalculationType = .compoundSaving
    var principleAmount: Double
    var interestRate: Double
    var futureValue: Double
    var terms: Double
    var payment: Double
    
    init(principleAmount: Double,
         interestRate: Double,
         futureValue: Double,
         terms: Double,
         payment: Double
    ) {
        self.principleAmount = principleAmount
        self.interestRate = interestRate
        self.terms = terms
        self.futureValue = futureValue
        self.payment = payment
        self.createdAt = "\(Date())"
    }
}

class CompoundSavingManager: ItemManageable {
    var isShowingYears: Bool = false
    var item: CompoundSaving! = CompoundSaving(principleAmount: 0,
                                               interestRate: 0,
                                               futureValue: 0,
                                               terms: 0,
                                               payment: 0)
        
    // MARK: Calculations
    func calculateFutureValue() {
        let PMT = item.payment
        let R = item.interestRate / 100
        let N = isShowingYears ? (item.terms) : (item.terms / 12)
        
        let numerator = ((pow((1 + (R / 12)), 12 * N)) - 1)
        let denomenator = R / 12
        let FV = PMT * (numerator / denomenator)
        item.futureValue = FV.isNaN ? 0 : FV.fixedTo(2)
    }
    
    func calculatePrincipleAmount() {
        let FV = item.futureValue
        let PMT = item.payment
        let R = item.interestRate / 100
        let CPY: Double = 12
        let N = isShowingYears ? (item.terms * 12) : (item.terms)
        
        let a: Double = (PMT * (pow((1 + R / CPY), CPY * N) - 1) / (R / CPY))
        let b: Double = (1 + R / CPY)
        let c: Double = pow((1 + R / CPY), CPY * N)
        let PV = (FV - a * b) / c
        item.principleAmount = PV.isNaN ? 0 : PV.fixedTo(2)
    }
    
    func calculatePaymentValue() {
        let FV = item.futureValue
        let R = item.interestRate / 100
        let CPY: Double = 12
        let N = isShowingYears ? (item.terms * 12) : (item.terms)

        let numerator = FV
        let denomenator = ((pow((1 + (R / CPY)), (12 * N)) - 1) / (R / 12))
        let PMT = Double( numerator / denomenator)
        print(PMT)
        item.payment = PMT.isNaN ? 0 : PMT.fixedTo(2)
    }
    
    func calculateTerms() {
        let FV = item.futureValue
        let PMT = item.payment
        let R = item.interestRate / 100

        let numerator = log(1 + ((R * FV) / PMT))
        let denomenator = log(1 + R)
        let N: Double = (numerator / denomenator);
        item.terms = N.isNaN ? 0 : N.fixedTo(2)
    }
    
    // MARK: Persisting the data
    func appendHistory() {
        var history = UserDefaults.standard.compoundSavings
        if history.count >= 5 {
            _ = history.removeFirst()
        }
        history.append(item)
        UserDefaults.standard.compoundSavings = history
    }
}


