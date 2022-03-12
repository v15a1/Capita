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

}
