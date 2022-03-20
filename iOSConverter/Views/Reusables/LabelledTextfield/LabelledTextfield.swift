//
//  LabelledTextField.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-05.
//

import UIKit

protocol LabelledTextfieldProtocol: AnyObject {
    func didBecomeFirstResponder(_ labelledTextfield: LabelledTextfield)
    func didResignFirstResponder(_ labelledTextfield: LabelledTextfield)
}

class LabelledTextfield: UIView {

    private let NibName: String = "LabelledTextfield"

    @IBOutlet weak var organizerStack: UIStackView!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputTextfield: UITextField!

    override var isFirstResponder: Bool {
        get {
            return inputTextfield.isFirstResponder
        }
    }

    var text: String {
        get {
            return inputTextfield.text ?? ""
        }

        set {
            removeHighlight()
            inputTextfield.text = newValue
        }
    }

    var title: String? {
        get {
            return inputLabel.text
        }

        set {
            inputLabel.text = newValue
        }
    }

    var isHighlighted: Bool = false

    weak var delegate: LabelledTextfieldProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitializer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitializer()
    }

    private func commonInitializer() {
        guard let view = self.loadFromNib(NibName) else { return }
        view.frame = self.bounds
        self.addSubview(view)

        inputTextfield.delegate = self
        inputTextfield.inputView = UIView()
        inputTextfield.inputAccessoryView = UIView()
        inputTextfield.layer.cornerRadius = 4
        inputTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        inputTextfield.leftViewMode = .always

    }

    func setup(label: String) {
        self.inputLabel.text = label
    }

    @IBAction func didEndEditting(_ sender: UITextField) {
        animateStack(axis: .horizontal)
    }

    @IBAction func didBeginEditting(_ sender: UITextField) {
        animateStack(axis: .vertical)
    }

    private func animateStack(axis: NSLayoutConstraint.Axis) {
        self.organizerStack.axis = axis
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    func highLightAnswer() {
        isHighlighted = true
        inputTextfield.layer.borderColor = UIColor.systemGreen.cgColor
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseInOut]) {
            self.inputTextfield.layer.borderWidth = 2
            self.inputTextfield.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        } completion: { _ in
            UIView.animate(withDuration: 1.2) {
                self.inputTextfield.backgroundColor = UIColor.lightGrey
            }
        }
    }

    func highlightEmpty() {
        isHighlighted = true
        inputTextfield.layer.borderColor = UIColor.systemRed.cgColor
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            self.inputTextfield.layer.borderWidth = 2
            self.inputTextfield.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
        } completion: { _ in
            UIView.animate(withDuration: 1.2) {
                self.inputTextfield.backgroundColor = UIColor.lightGrey
            }
        }
    }

    func removeHighlight() {
        if isHighlighted {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
                self.inputTextfield.layer.borderWidth = 0
            } completion: { _ in
                self.isHighlighted = false
            }
        }
    }
}

extension LabelledTextfield: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBecomeFirstResponder(self)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didResignFirstResponder(self)
    }
}

extension LabelledTextfield {
    func removeFinal() {
        if text.count > 0 {
            _ = text.removeLast()
        }
    }
}
