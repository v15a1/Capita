//
//  LoansViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-11.
//

import UIKit

class LoansViewController: RootStatefulViewController {

    lazy var textfieldLabels = [
        "Loan Amount (\(Currency.selected))",
        "Interest %",
        "Payment",
        "Number of Payments"
    ]

    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }

    lazy var loan: Loan = Loan(type: .loan)

    private func setup() {
        title = "Loans"
        stateKey = K.Keys.SavedLoansState
        navigationItem.largeTitleDisplayMode = .never
        for (idx, titleString) in textfieldLabels.enumerated() {
            let textfield = LabelledTextfield()
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
            textfield.delegate = self
            textfield.tag = idx
            textfield.title = titleString
            content.addArrangedSubview(textfield)
            textfields.append(textfield)
        }
    }

    private func calculateMissingValue() {
        let loanAmount = textfields.valueByTag(tag: 0)
        let interest = textfields.valueByTag(tag: 1)
        let monthlyPay = textfields.valueByTag(tag: 2)
        let terms = textfields.valueByTag(tag: 3)

        let values = [loanAmount, interest, monthlyPay, terms].compactMap { $0 }
        guard values.count >= 3 else {
            self.showError(message: "Ensure that 3 out of the 4 textfields are not empty") {
                self.highlightEmptyFields()
            }
            return
        }

        loan.principleAmount = loanAmount
        loan.interestRate = interest
        loan.monthlyPay = monthlyPay
        loan.numOfPayments = terms

        resetEmptyFields()
        var missingOperand: Double = 0

        if loanAmount == nil {
            emptyTextField = textfields.by(tag: 0)
            missingOperand = Util.shared.calculateLoanPrincipalAmount(interest: interest!, monthlyPay: monthlyPay!, terms: terms!)
            textfields.setText(String(missingOperand), forTag: 0)
            loan.principleAmount = missingOperand
        } else if interest == nil {
            emptyTextField = textfields.by(tag: 1)
            missingOperand = Util.shared.calculateLoanInterest(amount: loanAmount!, monthlyPay: monthlyPay!, terms: terms!) ?? 0
            textfields.setText(String(missingOperand), forTag: 1)
            loan.interestRate = missingOperand
        } else if monthlyPay == nil {
            emptyTextField = textfields.by(tag: 2)
            missingOperand = Util.shared.calculateLoanMonthlyPay(amount: loanAmount!, interest: interest!, terms: terms!)
            textfields.setText(String(missingOperand), forTag: 2)
            loan.monthlyPay = missingOperand
        } else if terms == nil {
            emptyTextField = textfields.by(tag: 3)
            missingOperand = Util.shared.calculateLoanTerms(amount: loanAmount!, interest: interest!, monthlyPay: monthlyPay!) ?? 0
            textfields.setText(String(Int(missingOperand)), forTag: 3)
            loan.numOfPayments = missingOperand
        }
    }

    override func calculate(_ sender: Any) {
        calculateMissingValue()
    }

    override func saveCalculation(_ sender: Any) {
        savePersistable(loan, forKey: K.Keys.SavedLoans)
    }
}

extension LoansViewController: LabelledTextfieldProtocol {
    func didBecomeFirstResponder(_ labelledTextfield: LabelledTextfield) {
        firstResponder = labelledTextfield
        showKeyboard()
    }

    func didResignFirstResponder(_ labelledTextfield: LabelledTextfield) {
        hideKeyboard()
    }


}
