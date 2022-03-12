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

class HelpViewController: UIViewController {

    var screen: HelpScreenType!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tutorialLabel: UILabel!

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
        descriptionLabel.text = "This screen allows you to calculate the interest required to return an amount for a future value for a fixed initial investment over a known period of time. \n\n• The application will automatically calculate the savings needed when 3 of the 4 values are provided \n"
    }
    
    @IBAction func didReadHelp(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
