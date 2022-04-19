//
//  Loan.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-20.
//

import Foundation

/// Loan Object
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


/// Loan Manager
class LoanManager: ItemManageable {

    var isShowingYears: Bool = false
    var item: Loan! = Loan(principleAmount: 0,
                           interestRate: 0,
                           monthlyPay: 0,
                           terms: 0)
    
    // MARK: Calculations
    func calculateMonthlyPayment() {
        let P = item.principleAmount
        let R = (item.interestRate / 100.0)
        let N = isShowingYears ? (item.terms * 12) : (item.terms / 12)
        
        let numerator = (P * (R / 12)) * pow((1 + (R / 12)), (12 * N))
        let denomenator = pow((1 + (R / 12)), (12 * N)) - 1
        let PMT = numerator / denomenator
        item.monthlyPay = PMT.isNaN ? 0 : PMT.fixedTo(2)
        print(PMT)
    }
    
    func calculatePrincipleAmount() {
        let PMT = item.monthlyPay
        let R = (item.interestRate / 100.0)
        let N = isShowingYears ? (item.terms * 12) : (item.terms)
        print(item.terms)
        let a = ((R / 12) + 1)
        let P = (PMT * ((pow(a, N) - 1)) * pow(a, -N)) / (R / 12)
        item.principleAmount = P.isNaN ? 0 : P.fixedTo(2)
    }
    
    func calculateInterestRate() {
        let PMT = item.monthlyPay
        let N = isShowingYears ? (item.terms * 12) : (item.terms)
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
        
        var I = Double(12 * x * 100).fixedTo(2)
        if I.isNaN || I.isInfinite || I < 0 {
            I = 0.00;
        }
        
        item.interestRate = I.isNaN ? 0 : I.fixedTo(2)
    }
    
    func calculateTerms() {
        let P = item.principleAmount
        let R = (item.interestRate / 100.0)
        let PMT = item.monthlyPay
        
        let numerator = log(1 - ((P / PMT) * (R / 12)))
        let denomenator = -log((R / 12) + 1)
        let N = (numerator / denomenator)
        item.terms = N.isNaN ? 0 : N.fixedTo(2)
    }
    
    // MARK: Persisting the data
    func appendHistory() {
        var history = UserDefaults.standard.loans
        if history.count >= 5 {
            _ = history.removeFirst()
        }
        history.append(item)
        UserDefaults.standard.loans = history
    }
}
