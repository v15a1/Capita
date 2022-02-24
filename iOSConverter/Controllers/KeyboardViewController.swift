//
//  KeyboardViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class KeyboardViewController: UIViewController {

    lazy var keyboard: Keyboard = Keyboard()
    var keyboardBottomAnchor: NSLayoutConstraint!

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
        keyboardBottomAnchor = keyboard.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            keyboardBottomAnchor,
            keyboard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            keyboard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            keyboard.heightAnchor.constraint(equalToConstant: 350)
        ])
    }

    func showKeyboard() {
        self.keyboard.isHidden = false
        keyboardBottomAnchor.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.keyboard.alpha = 1
        }
    }

    func hideKeyboard() {
        keyboardBottomAnchor.constant = keyboard.bounds.height + self.view.safeAreaInsets.bottom
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.keyboard.alpha = 0
        } completion: { _ in
            self.keyboard.isHidden = true
        }
    }
}
