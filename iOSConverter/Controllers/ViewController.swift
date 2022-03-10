//
//  ViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class ViewController: RootStatefulViewController {

    @IBOutlet weak var keyboard: Keyboard!
    @IBOutlet weak var keyboardBottomAnchor: NSLayoutConstraint!

    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet var inputTextfields: [LabelledTextfield]!

    override var firstResponder: LabelledTextfield? {
        didSet {
            if firstResponder == nil {
                hideKeyboard(firstResponder?.inputTextfield)
            }
        }
    }

    let textfieldLabels = [
        "Principal Amount",
        "Interest %",
        "Monthly Payment",
        "Future Value",
        "Number of Payments"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.firstResponder = nil
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func setup() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightBlue

        keyboard.delegate = self

        title = "Calculations"
        stateKey = K.Keys.SavedSavingsState

        keyboardBottomAnchor.constant = keyboard.bounds.height + self.view.safeAreaInsets.bottom
        keyboard.isHidden = true
        view.layoutIfNeeded()

        for (i, tf) in inputTextfields.enumerated() {
            tf.tag = i
            tf.delegate = self
            tf.title = textfieldLabels[i]
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.contentScrollView.addGestureRecognizer(tapGesture)

        restoreStateIfNeeded(inputTextfields)
    }

    private func showKeyboard() {
        self.keyboard.isHidden = false
        keyboardBottomAnchor.constant = 0
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut]) {
                self.view.layoutIfNeeded()
                self.keyboard.alpha = 1
            }
    }

    private func hideKeyboard(_ sender: UITextField?) {
        keyboardBottomAnchor.constant = keyboard.bounds.height + self.view.safeAreaInsets.bottom
        sender?.resignFirstResponder()
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut]) {
                self.view.layoutIfNeeded()
                self.keyboard.alpha = 0
            } completion: { _ in
                self.keyboard.isHidden = true
            }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showKeyboard()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        hideKeyboard(textField)
    }
}

extension ViewController: KeyboardDelegate {
    func didPressNumber(_ number: Int) {
        guard let tfString = firstResponder?.text else { return }
        if number == 0 {
            firstResponder?.text = Util.shared.includeZeroIfNeeded(tfString)
        } else {
            firstResponder?.text += "\(number)"
        }
        saveState()
    }

    func didPressDecimal() {
        guard let tfString = firstResponder?.text else { return }
        firstResponder?.text = Util.shared.applyDecimalIfNeeded(tfString)
        saveState()
    }

    func didPressDelete() {
        firstResponder?.removeFinal()
        saveState()
    }

    func willCloseKeyboard() {
        hideKeyboard(firstResponder?.inputTextfield)
    }
}

extension ViewController: LabelledTextfieldProtocol {
    func didBecomeFirstResponder(_ labelledTextfield: LabelledTextfield) {
        !isKeyboardOpen ? showKeyboard() : nil
        isKeyboardOpen = true
        firstResponder = labelledTextfield
    }

    func didResignFirstResponder(_ labelledTextfield: LabelledTextfield) {
        isKeyboardOpen = false
    }
}
