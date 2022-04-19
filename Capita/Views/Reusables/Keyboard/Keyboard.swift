//
//  Keyboard.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

/// Keyboard protocol
protocol KeyboardDelegate: AnyObject {
    func didPressNumber(_ number: Int)
    func didPressDecimal()
    func didPressMinus()
    func didPressDelete()
    func willDeleteAllText()
    func willCloseKeyboard()
}

class Keyboard: UIView {

    private let NibName: String = "Keyboard"
    static let height: CGFloat = 380 // Constant height for the keyboard
    
    weak var delegate: KeyboardDelegate?

    @IBOutlet var keyboardButtons: [UIButton]!
    @IBOutlet weak var deleteButton: UIButton!

    init() {
        super.init(frame: .zero)
        commonInitilizer()
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitilizer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitilizer()
    }

    // Setting up the keyboard
    private func commonInitilizer() {
        guard let view = self.loadFromNib(NibName) else { return }
        view.frame = self.bounds
        self.addSubview(view)

        keyboardButtons.forEach { button in
            button.layer.cornerRadius = K.View.CornerRadius
        }

        // Adding a long press gesture to delete the content in the entire text field
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressDeleteButton(_:)))
        longPressRecognizer.numberOfTouchesRequired = 1
        longPressRecognizer.allowableMovement = 10
        longPressRecognizer.minimumPressDuration = 0.5
        deleteButton.addGestureRecognizer(longPressRecognizer)
    }

    @objc private func didLongPressDeleteButton(_ sender: UILongPressGestureRecognizer) {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred() // Haptic feedback generator
        delegate?.willDeleteAllText()
    }

    // MARK: On press event actions + delegate function invocation
    @IBAction func didPressNumber(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
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
    @IBAction func didPressMinus(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        sender.backgroundColor = .navyBlue.withAlphaComponent(0.5)
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = .lightGrey
        }
        delegate?.didPressMinus()
    }
    
    @IBAction func didPressCloseKeyboard(_ sender: Any) {
        delegate?.willCloseKeyboard()
    }
}
