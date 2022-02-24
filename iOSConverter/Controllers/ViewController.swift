//
//  ViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var keyboard: Keyboard!
    @IBOutlet weak var keyboardBottomAnchor: NSLayoutConstraint!

    var isKeyboardShowing: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        keyboardBottomAnchor.constant = keyboard.bounds.height + self.view.safeAreaInsets.bottom
        keyboard.isHidden = true
        view.layoutIfNeeded()
    }


    private func setup() {
        textField.inputView = UIView()
        textField.inputAccessoryView = UIView()
        textField.delegate = self

        keyboard.delegate = self
    }

    private func showKeyboard() {
        self.keyboard.isHidden = false
        keyboardBottomAnchor.constant = 0
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
                self.keyboard.alpha = 1
            }
    }

    private func hideKeyboard(_ sender: UITextField) {
        keyboardBottomAnchor.constant = keyboard.bounds.height + self.view.safeAreaInsets.bottom
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseIn]) {
                self.view.layoutIfNeeded()
                self.keyboard.alpha = 0
            } completion: { _ in
                self.keyboard.isHidden = true
                sender.resignFirstResponder()
            }
    }

    @IBAction func didpressButton(_ sender: Any) {
        hideKeyboard(self.textField)
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
        // unused
    }

    func didPressDecimal() {
        // unused
    }

    func didPressDelete() {
        // unused
    }

    func willCloseKeyboard() {
        hideKeyboard(textField)
    }


}
