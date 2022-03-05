//
//  LabelledTextField.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-05.
//

import UIKit

protocol LabelledTextfieldProtocol: AnyObject {
    func didBecomeFirstResponder(_ textfield: UITextField)
    func didResignFirstResponder(_ textfield: UITextField)
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

    var text: String? {
        get {
            return inputTextfield.text
        }

        set {
            self.inputTextfield.text = newValue
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
}

extension LabelledTextfield: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBecomeFirstResponder(textField)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didResignFirstResponder(textField)
    }
}
