//
//  ViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var keyboard: Keyboard!
    @IBOutlet weak var keyboardBottomAnchor: NSLayoutConstraint!

    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet var inputTextfields: [LabelledTextfield]!

    var firstResponder: LabelledTextfield?{
        didSet {
            if firstResponder == nil {
                hideKeyboard(firstResponder?.inputTextfield)
            }
        }
    }
    var isKeyboardOpen: Bool = false

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        keyboardBottomAnchor.constant = keyboard.bounds.height + self.view.safeAreaInsets.bottom
        keyboard.isHidden = true
        view.layoutIfNeeded()

        for (i, tf) in inputTextfields.enumerated() {
            tf.delegate = self
            tf.title = textfieldLabels[i]
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.contentScrollView.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.firstResponder = nil
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func setup() {
//        textField.inputView = UIView()
//        textField.inputAccessoryView = UIView()
//        textField.delegate = self
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightBlue

        keyboard.delegate = self

        self.title = "Calculations"
        inputTextfields.first?.title = "Principal Amount $"

    }

    private func showOnboardingIfNeeded() {
        if !UserDefaults.standard.bool(forKey: .didFirstLoad) {
            if let vc = self.loadFromStoryboard("Tabbar", vc: .LandingViewController) as? LandingViewController {
                present(vc, animated: true, completion: nil)
            }
        }
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
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut]) {
                self.view.layoutIfNeeded()
                self.keyboard.alpha = 0
            } completion: { _ in
                self.keyboard.isHidden = true
                sender?.resignFirstResponder()
            }
    }

    @IBAction func didpressButton(_ sender: Any) {
        hideKeyboard(firstResponder?.inputTextfield)
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
        firstResponder?.text += "\(number)"
    }

    func didPressDecimal() {
        // unused
    }

    func didPressDelete() {
        firstResponder?.removeFinal()
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
