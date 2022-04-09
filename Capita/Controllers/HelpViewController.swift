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

    override func viewDidLoad() {
        super.viewDidLoad()
        setContentIfNeeded()
    }

    private func setContentIfNeeded() {
        switch (screen) {
        case .compoundSaving:
            setCompoundSavingsHelpScreen()
        case .simpleSaving:
            return
        case .loan:
            return
        case .none:
            return
        }
    }

    private func setCompoundSavingsHelpScreen() {
        titleLabel.text = "Help on Compound Savings"
        descriptionLabel.text = K.Content.SavingsHelpContent
    }
    
    private func setSimpleSavingsHelpScreen() {
        titleLabel.text = "Help on Simple Savings"
        descriptionLabel.text = K.Content.SavingsHelpContent
    }
    

    @IBAction func didReadHelp(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
