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
    
    var item: CompoundSaving! = CompoundSaving(principleAmount: 0,
                                               interestRate: 0,
                                               futureValue: 0,
                                               terms: 0,
                                               payment: 0)
        
    func calculateFutureValue() {
        let PMT = item.payment
        let I = item.interestRate / 100
        let PV = item.principleAmount
        let CPY: Double = 12
        let N = item.terms
        
        let a = pow((1 + I / CPY), CPY * N)
        let b = (PMT * (pow((1 + I / CPY), CPY * N) - 1) / (I / CPY))
        let FV = PV * a + b * (1 + I / CPY)
        item.futureValue = FV.fixedTo(2)
    }
    
    func calculatePrincipleAmount() {
        let FV = item.futureValue
        let PMT = item.payment
        let I = item.interestRate / 100
        let CPY: Double = 12
        let N = item.terms
        
        let a: Double = (PMT * (pow((1 + I / CPY), CPY * N) - 1) / (I / CPY))
        let b: Double = (1 + I / CPY)
        let c: Double = pow((1 + I / CPY), CPY * N)
        let PV = (FV - a * b) / c
        item.principleAmount = PV.fixedTo(2)
    }
    
    func calculatePaymentValue() {
        let FV = item.futureValue
        let PV = item.principleAmount
        let I = item.interestRate / 100
        let CPY: Double = 12
        let N = item.terms

        let numerator: Double = (FV - (PV * pow((1 + I / CPY), CPY * N)))
        let denomenator: Double = ((pow((1 + I / CPY), CPY * N) - 1) / (I / CPY))
        let PMT = Double( numerator / denomenator)
        item.payment = PMT.fixedTo(2)
    }
    
    func calculateTerms() {
        let FV = item.futureValue
        let PV = item.principleAmount
        let PMT = item.payment
        let I = item.interestRate / 100
        let CPY: Double = 12

        let a = log(FV + PMT + ((PMT * CPY) / I))
        let b = log(PV + PMT + ((PMT * CPY) / I))
        let c = (CPY * log(1 + (I / CPY)))
        let N: Double = ((a - b) / c);
        item.terms = N.fixedTo(2)
    }
    
    func appendHistory() {
        var history = UserDefaults.standard.compoundSavings
        if history.count >= 5 {
            _ = history.removeFirst()
        }
        history.append(item)
        UserDefaults.standard.compoundSavings = history
    }
    
}


