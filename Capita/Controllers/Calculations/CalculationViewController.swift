//
//  CalculationViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import UIKit
import SwiftUI

class CalculationViewController: RootViewController {

   // MARK: Variables + Views
    @IBOutlet weak var calculatorTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !UserDefaults.standard.bool(forKey: K.Keys.DidOnboard) {
            showOnboardingScreen()
        }
    }

    // MARK: Setup
    private func setup() {
        title = "Calculations"
        calculatorTableView.delegate = self
        calculatorTableView.dataSource = self
        calculatorTableView.separatorStyle = .none
        calculatorTableView.showsVerticalScrollIndicator = false

        calculatorTableView.register(UINib(nibName: CalculationTVC.identifier, bundle: nil), forCellReuseIdentifier: CalculationTVC.identifier)
    }

    private func showOnboardingScreen() {
        if let vc = loadFromStoryboard(K.Storyboard.Calculations, vc: .LandingViewController) as? LandingViewController {
            let child = UIHostingController(rootView: OnboardingView())
            child.view.translatesAutoresizingMaskIntoConstraints = false
            vc.view.addSubview(child.view)

            child.view.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
            child.view.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
            child.view.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
            child.view.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
            
            child.view.frame = vc.view.bounds
            vc.addChild(child)
            vc.isModalInPresentation = true
            present(vc, animated: true)
        }
    }
}

extension CalculationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CalculationTVC.identifier, for: indexPath) as? CalculationTVC {
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.title = "Compound Savings"
                cell.contentDescriptor = "Calculate your savings"
                cell.tint = .CrayonPeach
            } else if indexPath.row == 1 {
                cell.title = "Simple Savings"
                cell.contentDescriptor = "Calculate your Mortgage based on the interest"
                cell.tint = .CrayonBlue
            } else if indexPath.row == 2 {
                cell.title = "Mortgage & Loans"
                cell.contentDescriptor = "Find various values for a given loan"
                cell.tint = .CrayonPurple
            } else if indexPath.row == 3 {

            }

            return cell
        }

        return UITableViewCell()
    }

    /// Performs segue based on item selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0:
            performSegue(withIdentifier: K.Segues.SavingsCalculation, sender: self)
        case 1:
            performSegue(withIdentifier: K.Segues.MortgageCalculator, sender: self)
        case 2:
            performSegue(withIdentifier: K.Segues.LoansCalculation, sender: self)
        default:
            return
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CalculationTVC.height
    }

}
