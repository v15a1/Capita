//
//  LoansViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-11.
//

import UIKit

class LoansViewController: RootStatefulViewController {

    lazy var textfieldLabels = [
        "Loan Amount",
        "Interest %",
        "Payment",
        "Number of Payments"
    ]

    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }

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
            self.showError(message: "Ensure that 3 out of the 4 textfields are not empty")
            return
        }

        var missingOperand: Double = 0

        if interest == nil {
            missingOperand = Util.shared.calculateLoanInterest(amount: loanAmount, monthlyPay: monthlyPay, terms: terms) ?? 0
            textfields.setText(String(missingOperand), forTag: 1)
        }

        print("\(loanAmount), \(interest), \(monthlyPay), \(terms)")
    }

    override func calculate(_ sender: Any) {
        calculateMissingValue()
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
