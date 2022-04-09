//
//  HelpViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-12.
//

import UIKit

class HelpViewController: RootViewController {

    var screen: CalculationType!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContentIfNeeded()
    }

    private func setContentIfNeeded() {
        switch (screen) {
        case .compoundSaving:
            setCompoundSavingsHelpScreen()
        case .simpleSaving:
            setSimpleSavingsHelpScreen()
        case .loan:
            setLoansHelpScreen()
        case .none:
            return
        }
    }

    private func setCompoundSavingsHelpScreen() {
        titleLabel.text = "Compound Savings"
        descriptionLabel.text = K.Content.CompoundSavingsHelpContent
        closeButton.tintColor = UIColor.CrayonPeach
    }
    
    private func setSimpleSavingsHelpScreen() {
        titleLabel.text = "Simple Savings"
        descriptionLabel.text = K.Content.SimpleSavingsHelpContent
        closeButton.tintColor = UIColor.CrayonBlue
    }
    
    private func setLoansHelpScreen() {
        titleLabel.text = "Loans/Mortgage"
        descriptionLabel.text = K.Content.LoanHelpContent
        closeButton.tintColor = UIColor.CrayonPurple
    }
    

    @IBAction func didReadHelp(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
