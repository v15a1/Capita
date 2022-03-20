//
//  CalculationViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import UIKit

class CalculationViewController: UIViewController {

    @IBOutlet weak var calculatorTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = "Calculations"

        calculatorTableView.delegate = self
        calculatorTableView.dataSource = self
        calculatorTableView.separatorStyle = .none

        calculatorTableView.register(UINib(nibName: CalculationTVC.identifier, bundle: nil), forCellReuseIdentifier: CalculationTVC.identifier)
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
//                cell.image = UIImage(named: "dog")
                cell.title = "Savings"
                cell.contentDescriptor = "Calculate your savings"
                cell.tint = .CrayonPeach
            } else if indexPath.row == 1 {
//                cell.image = UIImage(named: "star")
                cell.title = "Mortgage "
                cell.contentDescriptor = "Calculate your Mortgage based on the interest"
                cell.tint = .CrayonBlue
            } else if indexPath.row == 2 {
//                cell.image = UIImage(named: "dog")
                cell.title = "Loans"
                cell.contentDescriptor = "Find various values for a given loan"
                cell.tint = .CrayonPurple
            } else if indexPath.row == 3 {

            }

            return cell
        }

        return UITableViewCell()
    }

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
