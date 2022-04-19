//
//  MortgageViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import UIKit

class SimpleSavingsViewController: RootStatefulViewController {
    
    let textfieldLabels = [
        "Amount (\(Currency.selected))",
        "Interest %",
        "Future Value (\(Currency.selected))",
        "Number of Payments"
    ]

    lazy var manager = SimpleSavingManager()

    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }

    private func setup() {
        stateKey = K.Keys.SavedSimpleSavings
        title = "Simple Savings"
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
        restoreState()
        selector.setMenuData(data: menuItems)
    }
    
    override func calculate() {
        let principalAmount = textfields.valueByTag(tag: 0)
        let interestRate = textfields.valueByTag(tag: 1)
        let futureValue = textfields.valueByTag(tag: 2)
        let terms = textfields.valueByTag(tag: 3)

        let values = [principalAmount, interestRate, futureValue, terms].compactMap { $0 }
        guard values.count >= 3 else {
            if let emptyTF = emptyTextField {
                emptyTF.text = ""
            }
            return
        }
        if emptyTextField != nil {
            emptyTextField?.text = ""
            manager.item.principleAmount = principalAmount ?? 0
            manager.item.interestRate = interestRate ?? 0
            manager.item.futureValue = futureValue ?? 0
            manager.item.terms = terms ?? 0

            if emptyTextField?.tag == 0 {
                manager.calculatePrincipleAmount()
                emptyTextField?.text = "\(manager.item.principleAmount)"
                state.values[emptyTextField!.tag] = "\(manager.item.principleAmount)"
            } else if emptyTextField?.tag == 1 {
                manager.calculateInterestRate()
                emptyTextField?.text = "\(manager.item.interestRate)"
                state.values[emptyTextField!.tag] = "\(manager.item.interestRate)"
            } else if emptyTextField?.tag == 2 {
                manager.calculateFutureValue()
                emptyTextField?.text = "\(manager.item.futureValue)"
                state.values[emptyTextField!.tag] = "\(manager.item.futureValue)"
            } else if emptyTextField?.tag == 3 {
                manager.calculateTerms()
                emptyTextField?.text = "\(manager.item.terms)"
                state.values[emptyTextField!.tag] = "\(manager.item.terms)"
            }
        } else {
            guard let emptyTf = textfields.getEmpty() else {
                return }
            emptyTextField = emptyTf
        }
        super.calculate()
    }
    
    override func saveCalculation(_ sender: Any) {
        if textfields.isSavable {
            
            manager.appendHistory()
            showAlert(title: "Saved", message: "Your calculation for simple savings has been saved")
        } else {
            showAlert(title: "Whoops!", message: "Your loan could not be saved. Please check if all the necessary fields have been filled")
        }
    }
    
    override func onSwitchChange(_ sender: UISwitch, to value: Bool) {
        manager.isShowingYears = value
    }
    
    override func onHelpButtonPress(_ sender: Any) {
        self.showHelp(type: .simpleSaving)
    }
}

extension SimpleSavingsViewController: LabelledTextfieldDelegate {
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
