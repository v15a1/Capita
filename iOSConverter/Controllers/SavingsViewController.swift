//
//  ViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class SavingsViewController: RootStatefulViewController {

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
        print("asdfjasdkfjaskfjaksdfkas")
    }

    override func onHelpButtonPress(_ sender: Any) {
        let storyboard = UIStoryboard(name: K.Storyboard.Tabbar, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: K.VC.HelpViewController) as? HelpViewController {
            vc.screen = .savings         
            present(vc, animated: true)
        }
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
