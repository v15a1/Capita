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
    typealias T = SimpleSaving
    var isShowingYears: Bool = false
    var item: T! = SimpleSaving(principleAmount: 0,
                                           interestRate: 0,
                                           futureValue: 0,
                                           terms: 0)
    
    // MARK: Calculations
    func calculateInterestRate() {
        let PV = item.principleAmount
        let FV = item.futureValue
        let CPY: Double = 12
        let N = isShowingYears ? (item.terms * 12) : (item.terms)
        let R = Double(CPY * (pow(FV / PV, (1 / (CPY * N))) - 1))
        
        print((N), " = ", R)
        item.interestRate = R.isNaN ? 0 : (R.fixedTo(2) * 100)
    }
    
    func calculateFutureValue() {
        let PV = item.principleAmount
        let R = item.interestRate / 100
        let N = isShowingYears ? (item.terms * 12) : (item.terms)
        let CPY: Double = 12
        let FV = Double(PV * (pow((1 + R / CPY), CPY * N)))
        item.futureValue = FV.isNaN ? 0 : FV.fixedTo(2)
    }
    
    func calculatePrincipleAmount() {
        let FV: Double = item.futureValue
        let R: Double = item.interestRate / 100
        let N: Double = isShowingYears ? (item.terms * 12) : (item.terms)
        let CPY: Double = 12
        let PV = Double(FV / pow(1 + (R / CPY), CPY * N))
        item.principleAmount = PV.isNaN ? 0 : PV.fixedTo(2)
    }
    
    func calculateTerms() {
        let PV = item.principleAmount
        let FV = item.futureValue
        let R = item.interestRate / 100
        let CPY: Double = 12
        let N = Double(log(FV / PV) / (CPY * log(1 + (R / CPY))))
        item.terms = N.isNaN ? 0 : N.fixedTo(2)
    }
    
    // MARK: Persisting the data
    func appendHistory() {
        var history = UserDefaults.standard.simpleSavings
        if history.count >= 5 {
            _ = history.removeFirst()
        }
        history.append(item)
        UserDefaults.standard.simpleSavings = history
    }
    
}
