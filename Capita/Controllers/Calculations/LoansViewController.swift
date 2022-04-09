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

    lazy var loan = LoanManager()

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
        var menuItems = [(name: String, index: Int)]()
        for (idx, titleString) in textfieldLabels.enumerated() {
            let textfield = LabelledTextfield()
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
            textfield.delegate = self
            textfield.tag = idx
            textfield.title = titleString
            menuItems.append((name: titleString, index: idx))
            content.addArrangedSubview(textfield)
            textfields.append(textfield)
        }
        selector.setMenuData(data: menuItems)
    }


    override func calculate() {
        let principalAmount = textfields.valueByTag(tag: 0)
        let interestRate = textfields.valueByTag(tag: 1)
        let payment = textfields.valueByTag(tag: 2)
        let terms = textfields.valueByTag(tag: 3)

        let values = [principalAmount, interestRate, terms, payment].compactMap { $0 }
        guard values.count >= 3 else {
            if let emptyTF = emptyTextField {
                emptyTF.text = ""
            }
            return
        }
        if emptyTextField != nil {
            emptyTextField?.text = ""
            loan.item.principleAmount = principalAmount ?? 0
            loan.item.interestRate = (interestRate ?? 0)
            loan.item.terms = terms ?? 0
            loan.item.monthlyPay = payment ?? 0
            
            if emptyTextField?.tag == 0 {
                loan.calculatePrincipleAmount()
                emptyTextField?.text = "\(loan.item.principleAmount)"
                state.values[emptyTextField!.tag] = "\(loan.item.principleAmount)"
            } else if emptyTextField?.tag == 2 {
                loan.calculateInterestRate()
                emptyTextField?.text = "\(loan.item.interestRate)"
                state.values[emptyTextField!.tag] = "\(loan.item.interestRate)"
            } else if emptyTextField?.tag == 3 {
                loan.calculateMonthlyPayment()
                emptyTextField?.text = "\(loan.item.monthlyPay)"
                state.values[emptyTextField!.tag] = "\(loan.item.monthlyPay)"
            } else if emptyTextField?.tag == 4 {
                loan.calculateTerms()
                emptyTextField?.text = "\(loan.item.terms)"
                state.values[emptyTextField!.tag] = "\(loan.item.terms)"
            }
        } else {
            guard let emptyTf = textfields.getEmpty(2) else {
                return }
            emptyTextField = emptyTf
        }
        super.calculate()
    }

    override func resetPage(_ sender: Any) {
        textfields.forEach { tf in
            tf.text = ""
        }
        hideKeyboard()
    }
    
    override func onHelpButtonPress(_ sender: Any) {
        self.showHelp(type: .loan)
    }

    override func saveCalculation(_ sender: Any) {
        if textfields.isSavable {
            loan.appendHistory()
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
