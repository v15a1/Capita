//
//  ViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class SavingsViewController: RootStatefulViewController {

    let textfieldLabels = [
        "Principal Amount (\(Currency.selected))",
        "Interest %",
        "Monthly Payment (\(Currency.selected))",
        "Future Value",
        "Number of Payments"
    ]

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
            textfield.title = titleString
            content.addArrangedSubview(textfield)
            textfields.append(textfield)
        }
        restoreStateIfNeeded()
    }

    override func calculate(_ sender: Any) {

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
