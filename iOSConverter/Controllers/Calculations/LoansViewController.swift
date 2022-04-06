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

    lazy var loan = Loan(icon: "",
                           type: .loan,
                           principleAmount: 0,
                           interestRate: 0,
                           monthlyPay: 0,
                           numOfPayments: 0)

    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        selector.setMenuData(data: textfieldLabels)
    }

    private func calculateMissingValue() {
        let loanAmount = textfields.valueByTag(tag: 0)
        let interest = textfields.valueByTag(tag: 1)
        let monthlyPay = textfields.valueByTag(tag: 2)
        let terms = textfields.valueByTag(tag: 3)

        let values = [loanAmount, interest, monthlyPay, terms].compactMap { $0 }
        guard values.count >= 3 else {
            return
        }

        loan.principleAmount = loanAmount ?? 0
        loan.interestRate = interest ?? 0
        loan.monthlyPay = monthlyPay ?? 0
        loan.numOfPayments = terms ?? 0

        var missingOperand: Double = 0

        if loanAmount == nil {
            emptyTextField = textfields.by(tag: 0)
            missingOperand = Util.shared.calculateLoanPrincipalAmount(interest: interest!, monthlyPay: monthlyPay!, terms: terms!)
            textfields.setText(String(missingOperand), forTag: 0)
            loan.principleAmount = missingOperand.fixedTo(2)
        } else if interest == nil {
            emptyTextField = textfields.by(tag: 1)
            missingOperand = Util.shared.calculateLoanInterest(amount: loanAmount!, monthlyPay: monthlyPay!, terms: terms!) ?? 0
            textfields.setText(String(missingOperand), forTag: 1)
            loan.interestRate = missingOperand.fixedTo(2)
        } else if monthlyPay == nil {
            emptyTextField = textfields.by(tag: 2)
            missingOperand = Util.shared.calculateLoanMonthlyPay(amount: loanAmount!, interest: interest!, terms: terms!)
            textfields.setText(String(missingOperand), forTag: 2)
            loan.monthlyPay = missingOperand.fixedTo(2)
        } else if terms == nil {
            emptyTextField = textfields.by(tag: 3)
            missingOperand = Util.shared.calculateLoanTerms(amount: loanAmount!, interest: interest!, monthlyPay: monthlyPay!) ?? 0
            print("missingOperand: ", missingOperand)
            textfields.setText(String(Int(missingOperand)), forTag: 3)
            loan.numOfPayments = missingOperand.fixedTo(2)
        }
    }

    override func calculate() {
        calculateMissingValue()
    }

    override func resetPage(_ sender: Any) {
        textfields.forEach { tf in
            tf.text = ""
        }
        hideKeyboard()
    }

    override func saveCalculation(_ sender: Any) {
        if textfields.isSavable {
            var history = UserDefaults.standard.loans
            if history.count >= 5 {
                _ = history.removeFirst()
            }
            history.append(loan)
            UserDefaults.standard.loans = history
            showAlert(title: "Saved", message: "Your loan has been saved")
        } else {
            showAlert(title: "Whoops!", message: "Your loan could not be saved. Please check if all the necessary fields have been filled")
        }
    }
}

extension LoansViewController: LabelledTextfieldProtocol {
    func didBecomeFirstResponder(_ labelledTextfield: LabelledTextfield) {
        if selectedParameterIndex < 0 {
            showAlert(title: "Whoops!", message: "Please select a parameter to calculate") {
                self.resignFirstResponder()
            }
            return
        }
        !isKeyboardOpen ? showKeyboard() : nil
        isKeyboardOpen = true
        firstResponder = labelledTextfield
    }

    func didResignFirstResponder(_ labelledTextfield: LabelledTextfield) {
        isKeyboardOpen = false
    }


}
