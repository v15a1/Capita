//
//  Loan.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-20.
//

import Foundation

struct Loan: Persistable {
    var createdAt: String
    var type: CalculationType = .loan
    var principleAmount: Double
    var interestRate: Double
    var monthlyPay: Double
    var terms: Double

    init(principleAmount: Double,
         interestRate: Double,
         monthlyPay: Double,
         terms: Double) {
        self.principleAmount = principleAmount
        self.interestRate = interestRate
        self.monthlyPay = monthlyPay
        self.terms = terms
        self.createdAt = "\(Date())"
    }
}

class LoanManager: ItemManageable {

    var isShowingYears: Bool = false
    var item: Loan! = Loan(principleAmount: 0,
                           interestRate: 0,
                           monthlyPay: 0,
                           terms: 0)
    
    func calculateMonthlyPayment() {
        let P = item.principleAmount
        let R = (item.interestRate / 100.0) / 12
        let N = isShowingYears ? (item.terms * 12) : item.terms
        let PMT = (R * P) / (1 - pow(1 + R, -N))
        item.monthlyPay = PMT.isNaN ? 0 : PMT.fixedTo(2)
    }
    
    func calculatePrincipleAmount() {
        let PMT = item.monthlyPay
        let R = (item.interestRate / 100.0) / 12
        let N = isShowingYears ? (item.terms * 12) : item.terms
        let P = (PMT / R) * (1 - (1 / pow(1 + R, N)))
        item.principleAmount = P.isNaN ? 0 : P
    }
    
    func calculateInterestRate() {
        let PMT = item.monthlyPay
        let N = isShowingYears ? (item.terms * 12) : item.terms
        let P = item.principleAmount
        
        var x = 1 + (((PMT * N / P) - 1) / 12)
        let FINANCIAL_PRECISION = Double(0.000001) // 1e-6
        
        func F(_ x: Double) -> Double { // f(x)
            return Double(P * x * pow(1 + x, N) / (pow(1 + x, N) - 1) - PMT);
        }
                            
        func FPrime(_ x: Double) -> Double { // f'(x)
            let c_derivative = pow(x + 1, N)
            return Double(P * pow(x + 1, N-1) *
                (x * c_derivative + c_derivative - (N * x) - x - 1)) / pow(c_derivative - 1, 2)
        }
        
        while(abs(F(x)) > FINANCIAL_PRECISION) {
            x = x - F(x) / FPrime(x)
        }
        
        var R = Double(12 * x * 100).fixedTo(2)
        if R.isNaN || R.isInfinite || R < 0 {
            R = 0.00;
        }
        
        item.interestRate = R.isNaN ? 0 : R
    }
    
    func calculateTerms() {
        let P = item.principleAmount
        let R = (item.interestRate / 100.0) / 12
        let PMT = (R * P) / (1 - pow(1 + R, -1))
        var N: Double = 0
        
        let minMonthlyPayment = PMT - P
        
        if Int(PMT) <= Int(minMonthlyPayment) {
            item.terms = N
        }
        
        let PM = item.monthlyPay
        let I = (item.interestRate / 100.0) / 12
        let D = PM / I
        N = (log(D / (D - P)) / log(1 + I))
        item.terms = N.isNaN ? 0 : N
    }
    
    func appendHistory() {
        var history = UserDefaults.standard.loans
        if history.count >= 5 {
            _ = history.removeFirst()
        }
        history.append(item)
        UserDefaults.standard.loans = history
    }
}
