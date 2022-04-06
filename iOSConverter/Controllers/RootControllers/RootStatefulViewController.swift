//
//  RootStatefulViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import UIKit

class RootStatefulViewController: RootViewController, SaveImplementable {

    lazy var contentScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()

    lazy var content: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()

    lazy var keyboard: Keyboard = {
        let keyboard = Keyboard()
        keyboard.delegate = self
        keyboard.isHidden = true
        keyboard.alpha = 0
        keyboard.backgroundColor = .red
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        return keyboard
    }()

    lazy var selector: SelectorMenu  = {
        let selector = SelectorMenu()
        selector.delegate = self
        selector.title = "Parameter to Calculate"
        return selector
    }()

    var keyboardBottomAnchor: NSLayoutConstraint!
    var textfields: [LabelledTextfield] = []

    var isKeyboardOpen: Bool = false
    var state = SaveState( values: [:])
    var stateKey: String!
    
    var selectedParameterIndex: Int = -1 {
        didSet {
            selector.selection = selectedParameterIndex
        }
    }

    var firstResponder: LabelledTextfield? {
        didSet {
            if firstResponder == nil {
                hideKeyboard()
            }
        }
    }

    var emptyTextField: LabelledTextfield? {
        didSet {
            emptyTextField?.isEnabled = false
            state.emptyTFTag = emptyTextField?.tag
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        restoreState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBarButtons()
    }

    private func setup() {
        self.view.addSubview(contentScrollView)
        self.contentScrollView.addSubview(content)
        self.view.addSubview(keyboard)
        keyboardBottomAnchor = keyboard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: Keyboard.height)

        NSLayoutConstraint.activate([
            keyboard.heightAnchor.constraint(equalToConstant: Keyboard.height),
            keyboard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            keyboard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            keyboardBottomAnchor,

            contentScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: keyboard.topAnchor),

            content.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: 20),
            content.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor, constant: -20),
            content.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 20),
            content.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: 8),
            content.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -40),
        ])

        content.addArrangedSubview(selector)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.contentScrollView.addGestureRecognizer(tapGesture)
        self.view.backgroundColor = .systemBackground
    }

    private func setupBarButtons() {
        self.navigationItem.rightBarButtonItems?.removeAll()
        var barButtons = [UIBarButtonItem]()

        let helpBarButton = UIButton(type: .system)
        helpBarButton.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        helpBarButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        helpBarButton.addTarget(self, action: #selector(onHelpButtonPress(_:)), for: .touchUpInside)
        let helpBarButtonItem = UIBarButtonItem(customView: helpBarButton)
        barButtons.append(helpBarButtonItem)

        let saveBarButton = UIButton(type: .system)
        saveBarButton.setImage(UIImage(systemName: "square.and.arrow.down.fill"), for: .normal)
        saveBarButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        saveBarButton.addTarget(self, action: #selector(saveCalculation(_:)), for: .touchUpInside)
        let saveBarButtonItem = UIBarButtonItem(customView: saveBarButton)
        barButtons.append(saveBarButtonItem)

        let resetBarButton = UIButton(type: .system)
        resetBarButton.setImage(UIImage(systemName: "gobackward"), for: .normal)
        resetBarButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        resetBarButton.addTarget(self, action: #selector(resetPage(_:)), for: .touchUpInside)
        let resetBarButtonItem = UIBarButtonItem(customView: resetBarButton)
        barButtons.append(resetBarButtonItem)


        self.navigationItem.rightBarButtonItems = barButtons
    }

    @objc func onHelpButtonPress(_ sender: Any){}

    @objc func calculate(){}

    @objc func saveCalculation(_ sender: Any) {}

    @objc func resetPage(_ sender: Any) {
        textfields.forEach {
            if $0.isEnabled {
                $0.text = ""
            }
        }
        state = SaveState(values: [:])
        saveState()
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.firstResponder = nil
    }

    func showKeyboard() {
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

    func hideKeyboard() {
        keyboardBottomAnchor.constant = keyboard.bounds.height + self.view.safeAreaInsets.bottom
        firstResponder?.inputTextfield.resignFirstResponder()
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut]) {
                self.view.layoutIfNeeded()
                self.keyboard.alpha = 0
            }
    }

    func abruptlyHideKeyboard() {
        self.view.layoutIfNeeded()
        self.keyboard.alpha = 0
        self.keyboard.isHidden = true
    }
}

extension RootStatefulViewController: KeyboardDelegate {
    func willDeleteAllText() {
        firstResponder?.text = ""
    }

    func didPressNumber(_ number: Int) {
        guard let tfString = firstResponder?.text else { return }
        if number == 0 {
            firstResponder?.text = Util.shared.includeZeroIfNeeded(tfString)
        } else {
            firstResponder?.text! += "\(number)"
        }
        saveStateOnEdit()

        calculate()
    }

    func didPressDecimal() {
        guard let tfString = firstResponder?.text else { return }
        firstResponder?.text = Util.shared.applyDecimalIfNeeded(tfString)
        saveStateOnEdit()
        calculate()
    }

    func didPressDelete() {
        firstResponder?.removeFinal()
        saveStateOnEdit()

        calculate()
    }

    func willCloseKeyboard() {
        hideKeyboard()
    }
}

extension RootStatefulViewController: ParameterSelectorDelegate {
    func didSelectMenuItem(selectedIndex: Int, item: String) {
        selectedParameterIndex = selectedIndex
        textfields.forEach { $0.isEnabled = true }
        textfields[selectedIndex].isEnabled = false
        state.emptyTFTag = selectedIndex
    }
    
}
