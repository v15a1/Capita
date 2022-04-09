//
//  ViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class CompoundSavingsViewController: RootStatefulViewController {
    
    let textfieldLabels = [
        "Amount (\(Currency.selected))",
        "Interest %",
        "Future Value (\(Currency.selected))",
        "Terms",
        "Payment (\(Currency.selected))"
    ]
    
    lazy var saving = CompoundSavingManager()
    
    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        abruptlyHideKeyboard()
    }
    
    private func setup() {
        stateKey = K.Keys.SavedCompoundSavings
        title = "Compound Savings"
        navigationItem.largeTitleDisplayMode = .never
        var menuItems = [(name: String, index: Int)]()
        for (idx, titleString) in textfieldLabels.enumerated() {
            let textfield = LabelledTextfield()
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
            textfield.delegate = self
            textfield.tag = idx
            textfield.title = titleString
            content.addArrangedSubview(textfield)
            textfields.append(textfield)
            if idx != 1 {
                menuItems.append((name: titleString, index: idx))
            }
        }
        restoreState()
        selector.setMenuData(data: menuItems)
    }
    
    override func calculate() {
        let principalAmount = textfields.valueByTag(tag: 0)
        let interestRate = textfields.valueByTag(tag: 1)
        let futureValue = textfields.valueByTag(tag: 2)
        let terms = textfields.valueByTag(tag: 3)
        let payment = textfields.valueByTag(tag: 4)

        let values = [principalAmount, interestRate, futureValue, terms, payment].compactMap { $0 }
        guard values.count >= 4 else {
            if let emptyTF = emptyTextField {
                emptyTF.text = ""
            }
            return }
        if emptyTextField != nil {
            emptyTextField?.text = ""
            saving.item.principleAmount = principalAmount ?? 0
            saving.item.interestRate = interestRate ?? 0
            saving.item.futureValue = futureValue ?? 0
            saving.item.terms = terms ?? 0
            saving.item.payment = payment ?? 0
            
            if emptyTextField?.tag == 0 {
                saving.calculatePrincipleAmount()
                emptyTextField?.text = "\(saving.item.principleAmount)"
                state.values[emptyTextField!.tag] = "\(saving.item.principleAmount)"
            } else if emptyTextField?.tag == 2 {
                saving.calculateFutureValue()
                emptyTextField?.text = "\(saving.item.futureValue)"
                state.values[emptyTextField!.tag] = "\(saving.item.futureValue)"
            } else if emptyTextField?.tag == 3 {
                saving.calculateTerms()
                emptyTextField?.text = "\(saving.item.terms)"
                state.values[emptyTextField!.tag] = "\(saving.item.terms)"
            } else if emptyTextField?.tag == 4 {
                saving.calculatePaymentValue()
                emptyTextField?.text = "\(saving.item.payment)"
                state.values[emptyTextField!.tag] = "\(saving.item.payment)"
            }
        } else {
            guard let emptyTf = textfields.getEmpty(2) else {
                return }
            emptyTextField = emptyTf
        }
        super.calculate()
    }
    
    override func saveCalculation(_ sender: Any) {
        if textfields.isSavable {
            saving.appendHistory()
            showAlert(title: "Saved", message: "Your calculation for compound savings has been saved")
        } else {
            showAlert(title: "Whoops!", message: "Your loan could not be saved. Please check if all the necessary fields have been filled")
        }
    }
    
    override func onHelpButtonPress(_ sender: Any) {
        self.showHelp(type: .compoundSaving)
    }
    
}

extension CompoundSavingsViewController: LabelledTextfieldProtocol {
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
