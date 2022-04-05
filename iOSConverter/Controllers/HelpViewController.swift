//
//  HelpViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-12.
//

import UIKit

enum HelpScreenType {
    case savings
    case loans
    case mortgate
}

class HelpViewController: RootViewController {

    var screen: HelpScreenType!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setContentIfNeeded()
    }

    private func setContentIfNeeded() {
        switch (screen) {
        case .savings:
            setSavingsHelpScreen()
        case .loans:
            return
        case .mortgate:
            return
        case .none:
            return
        }
    }

    private func setSavingsHelpScreen() {
        titleLabel.text = "Help on Savings"
        descriptionLabel.text = K.Content.SavingsHelpContent
    }

    @IBAction func didReadHelp(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
