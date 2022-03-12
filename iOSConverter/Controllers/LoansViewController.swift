//
//  LoansViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-11.
//

import UIKit

class LoansViewController: RootStatefulViewController {

    let textfieldLabels = [
        "Principal Amount",
        "Interest %",
        "Monthly Payment",
        "Future Value",
        "Number of Payments"
    ]

    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
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
        }

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
