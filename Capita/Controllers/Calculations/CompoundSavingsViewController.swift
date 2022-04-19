//
//  ViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class CompoundSavingsViewController: RootStatefulViewController {
    
    // MARK: Variables
    let textfieldLabels = [
        "Amount (\(Currency.selected))",
        "Interest %",
        "Future Value (\(Currency.selected))",
        "Payment (\(Currency.selected))",
        "No. of Payments"
    ]
    
    lazy var manager = CompoundSavingManager()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        abruptlyHideKeyboard()
    }
    
    // MARK: Setup
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
    
    // MARK: Calculate
    override func calculate() {
        let principalAmount = textfields.valueByTag(tag: 0)
        let interestRate = textfields.valueByTag(tag: 1)
        let futureValue = textfields.valueByTag(tag: 2)
        let payment = textfields.valueByTag(tag: 3)
        let terms = textfields.valueByTag(tag: 4)

        // Validating the TFs to see if necessary data has been entered
        let values = [principalAmount, interestRate, futureValue, terms, payment].compactMap { $0 }
        guard values.count >= 4 else {
            if let emptyTF = emptyTextField {
                emptyTF.text = ""
            }
            return }
        if emptyTextField != nil {
            emptyTextField?.text = ""
            manager.item.principleAmount = principalAmount ?? 0
            manager.item.interestRate = interestRate ?? 0
            manager.item.futureValue = futureValue ?? 0
            manager.item.terms = terms ?? 0
            manager.item.payment = payment ?? 0
            
            if emptyTextField?.tag == 0 {
                manager.calculatePrincipleAmount()
                emptyTextField?.text = "\(manager.item.principleAmount)"
                state.values[emptyTextField!.tag] = "\(manager.item.principleAmount)"
            } else if emptyTextField?.tag == 2 {
                manager.calculateFutureValue()
                emptyTextField?.text = "\(manager.item.futureValue)"
                state.values[emptyTextField!.tag] = "\(manager.item.futureValue)"
            } else if emptyTextField?.tag == 3 {
                manager.calculatePaymentValue()
                emptyTextField?.text = "\(manager.item.payment)"
                state.values[emptyTextField!.tag] = "\(manager.item.payment)"
            } else if emptyTextField?.tag == 4 {
                manager.calculateTerms()
                emptyTextField?.text = "\(manager.item.terms)"
                state.values[emptyTextField!.tag] = "\(manager.item.terms)"
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
            manager.appendHistory()
            showAlert(title: "Saved", message: "Your calculation for compound savings has been saved")
        } else {
            showAlert(title: "Whoops!", message: "Your loan could not be saved. Please check if all the necessary fields have been filled")
        }
    }
    
    /// Presents help screen
    /// - Parameter sender: Invoker
    override func onHelpButtonPress(_ sender: Any) {
        self.showHelp(type: .compoundSaving)
    }
    
    override func onSwitchChange(_ sender: UISwitch, to value: Bool) {
        manager.isShowingYears = value
    }
    
}

extension CompoundSavingsViewController: LabelledTextfieldDelegate {
    
    /// Did become first responder event handler
    /// - Parameter labelledTextfield: Textfield that `isFirstResponder`
    func didBecomeFirstResponder(_ labelledTextfield: LabelledTextfield) {
        if selectedParameterIndex < 0 {
            // Showing an alert if no parameter to calculate is selected
            showAlert(title: "Whoops!", message: "Please select a parameter to calculate") {
                self.resignFirstResponder()
            }
            return
        }
        !isKeyboardOpen ? showKeyboard() : nil
        isKeyboardOpen = true
        firstResponder = labelledTextfield
    }
    
    
    /// Did resign first responder event hander
    /// - Parameter labelledTextfield: Textfield where `isFirstResponder` just resigned
    func didResignFirstResponder(_ labelledTextfield: LabelledTextfield) {
        isKeyboardOpen = false
    }
}
