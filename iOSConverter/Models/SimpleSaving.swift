//
//  SimpleSaving.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-04-06.
//

import Foundation

struct SimpleSaving: Persistable {
    var createdAt: String
    var type: CalculationType = .simpleSaving
    var principleAmount: Double
    var interestRate: Double
    var futureValue: Double
    var terms: Double

    init(principleAmount: Double,
         interestRate: Double,
         futureValue: Double,
         terms: Double) {
        self.principleAmount = principleAmount
        self.interestRate = interestRate
        self.terms = terms
        self.futureValue = futureValue
        self.createdAt = "\(Date())"
    }
}

class SimpleSavingManager: ItemManageable {
    
    var item: SimpleSaving! = SimpleSaving(principleAmount: 0,
                                           interestRate: 0,
                                           futureValue: 0,
                                           terms: 0)
    
    func calculateInterestRate() {
        let PV = item.principleAmount
        let FV = item.futureValue
        let CPY: Double = 12
        let N = item.terms
        let I = Double(CPY * (pow(FV / PV, (1 / (CPY * N))) - 1)) 
        item.interestRate = I.fixedTo(2)
    }
    
    func calculateFutureValue() {
        let PV = item.principleAmount
        let I = item.interestRate / 100
        let N = item.terms
        let CPY: Double = 12
        let FV = Double(PV * (pow((1 + I / CPY), CPY * N)))
        item.futureValue = FV.fixedTo(2)
    }
    
    func calculatePrincipleAmount() {
        let FV: Double = item.futureValue
        let I: Double = item.interestRate / 100
        let N: Double = item.terms
        let CPY: Double = 12
        let PV = Double(FV / pow(1 + (I / CPY), CPY * N))
        item.principleAmount = PV.fixedTo(2)
    }
    
    func calculateTerms() {
        let PV = item.principleAmount
        let FV = item.futureValue
        let I = item.interestRate / 100
        let CPY: Double = 12
        let N = Double(log(FV / PV) / (CPY * log(1 + (I / CPY))))
        item.terms = N.fixedTo(2)
    }
    
    func appendHistory() {
        var history = UserDefaults.standard.simpleSavings
        if history.count >= 5 {
            _ = history.removeFirst()
        }
        history.append(item)
        print(item)
        UserDefaults.standard.simpleSavings = history
    }
    
}
