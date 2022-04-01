//
//  ViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class SavingsViewController: RootStatefulViewController {

    let textfieldLabels = [
        "Amount (\(Currency.selected))",
        "Interest %",
        "Compounds/yr",
        "Future Value (\(Currency.selected))",
        "Number of Years"
    ]

    var saving = Saving(icon: "",
                        principleAmount: 0,
                        interestRate: 0,
                        futureValue: 0,
                        numOfPayments: 0)

    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        abruptlyHideKeyboard()
    }

    private func setup() {
        stateKey = K.Keys.SavedLoansState
        navigationItem.largeTitleDisplayMode = .never
        for (idx, titleString) in textfieldLabels.enumerated() {
            let textfield = LabelledTextfield()
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
            textfield.delegate = self
            textfield.tag = idx
            if idx == 2 {
                textfield.isEnabled = false
                textfield.text = "12"
                state.values[idx] = "12"
            }
            textfield.title = titleString
            content.addArrangedSubview(textfield)
            textfields.append(textfield)
        }
        restoreState()
    }

    override func calculate() {
        let principalAmount = textfields.valueByTag(tag: 0)
        let interestRate = textfields.valueByTag(tag: 1)
        let futureValue = textfields.valueByTag(tag: 3)
        let terms = textfields.valueByTag(tag: 3)

        let values = [principalAmount, interestRate, futureValue, terms].compactMap { $0 }
        guard values.count >= 4 else {
            if let emptyTF = emptyTextField {
                emptyTF.text = ""
            }
            print("values.count >= 4")
            return }
        if emptyTextField != nil {
            saving.principleAmount = principalAmount ?? 0
            saving.interestRate = (interestRate ?? 0) / 100
            saving.futureValue = futureValue ?? 0
            saving.numOfPayments = terms ?? 0


            if emptyTextField?.tag == 0 {
                print("tag == 0")
                let denWOExp: Double = 1 + (saving.interestRate / 12)
                let exp: Double = 12 * saving.numOfPayments
                let denomenator: Double = pow(denWOExp, exp)
                saving.principleAmount = saving.futureValue / denomenator
                emptyTextField?.text = "\(saving.principleAmount)"
            } else if emptyTextField?.tag == 1 {
                print("tag == 1")
                let futureDivPrincipal: Double = saving.futureValue / saving.principleAmount
                let monthsInYears: Double = saving.numOfPayments / 12
                let exponent: Double = 1 / ( 12 * monthsInYears)
                saving.interestRate = 12 * (pow(futureDivPrincipal, exponent) - 1)
                emptyTextField?.text = "\(saving.interestRate)"
            } else if emptyTextField?.tag == 4 {
                print("tag == 3")
                let numerator = log((saving.futureValue / saving.principleAmount))
                let demonenator = 12 * (log((1 + (saving.interestRate / 12))))
                saving.numOfPayments = (numerator / demonenator) / 12
                emptyTextField?.text = "\(saving.numOfPayments)"
            } else {
                print("Empty TF is ", emptyTextField?.tag)
            }
            textfields.setText("12", forTag: 2)
        } else {
            guard let emptyTf = textfields.getEmpty(2) else {
                print("No empty")
                return }
            emptyTextField = emptyTf
        }



    }

    override func onHelpButtonPress(_ sender: Any) {
        self.showHelp(type: .savings)
    }

}

extension SavingsViewController: LabelledTextfieldProtocol {
    func didBecomeFirstResponder(_ labelledTextfield: LabelledTextfield) {
        !isKeyboardOpen ? showKeyboard() : nil
        isKeyboardOpen = true
        firstResponder = labelledTextfield
    }

    func didResignFirstResponder(_ labelledTextfield: LabelledTextfield) {
        isKeyboardOpen = false
    }
}
