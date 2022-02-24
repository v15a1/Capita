//
//  Keyboard.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

protocol KeyboardDelegate: AnyObject {
    func didPressNumber(_ number: Int)
    func didPressDecimal()
    func didPressDelete()
    func willCloseKeyboard()
}

class Keyboard: UIView {

    private let XibName: String = "Keyboard"

    var contentView: UIView!
    weak var delegate: KeyboardDelegate?

    @IBOutlet var keyboardButtons: [UIButton]!


    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitilizer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitilizer()
    }

    private func commonInitilizer() {
        guard let view = loadFromXib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view

        keyboardButtons.forEach { button in
            button.layer.cornerRadius = K.View.CornerRadius
//            button.setShadow(withColor: .navyBlue, withAlpha: 0.1)
        }
    }

    func loadFromXib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: XibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    @IBAction func didPressNumber(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        sender.backgroundColor = .navyBlue.withAlphaComponent(0.5)
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = .lightGrey
        }

        let number = Int((sender.titleLabel?.text)!)
        delegate?.didPressNumber(number!)
    }

    @IBAction func didPressDelete(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        delegate?.didPressDelete()
    }

    @IBAction func didPressDecimal(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        sender.backgroundColor = .navyBlue.withAlphaComponent(0.5)
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = .lightGrey
        }

        delegate?.didPressDecimal()
    }

    @IBAction func didPressCloseKeyboard(_ sender: Any) {
        delegate?.willCloseKeyboard()
    }
}
