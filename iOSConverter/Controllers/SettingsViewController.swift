//
//  SettingsViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-09.
//

import UIKit

class SettingsViewController: RootViewController {

    @IBOutlet weak var settingsTableView: UITableView!

    var precision: Precision!
    var currency: Currency!
    var calcMode: Calculate!

    let helpContent = [
        ["title": "Savings", "description": "Help regarding savings"],
        ["title": "Mortgage", "description": "Help regarding mortgages"],
        ["title": "Loans", "description": "Help regarding loans"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(currency.rawValue, forKey: K.Keys.Currency)
        UserDefaults.standard.set(precision.rawValue, forKey: K.Keys.Precision)
        UserDefaults.standard.set(calcMode.rawValue, forKey: K.Keys.AutoCalculate)

    }

    private func setup() {
        title = "Settings"

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.separatorStyle = .none
        settingsTableView.register(UINib(nibName: HelpTVC.identifier, bundle: nil), forCellReuseIdentifier: HelpTVC.identifier)
        settingsTableView.register(UINib(nibName: ConfigurationTVC.identifier, bundle: nil), forCellReuseIdentifier: ConfigurationTVC.identifier)

        precision = Precision(rawValue: UserDefaults.standard.integer(forKey: K.Keys.Precision)) ?? .high
        currency = Currency(rawValue: UserDefaults.standard.string(forKey: K.Keys.Currency) ?? "") ?? .usd
        calcMode = Calculate(rawValue: UserDefaults.standard.string(forKey: K.Keys.AutoCalculate) ?? "") ?? .manual
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
             return "Settings"
        } else {
            return "Help"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: ConfigurationTVC.identifier, for: indexPath) as? ConfigurationTVC {
                    cell.configLabel.text = "Currency"
                    cell.delegate = self
                    cell.type = .currency
                    cell.setSegment(self.currency)
                    cell.selectionStyle = .none
                    return cell
                }
            } else if indexPath.row == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: ConfigurationTVC.identifier, for: indexPath) as? ConfigurationTVC {
                    cell.configLabel.text = "Precision"
                    cell.delegate = self
                    cell.type = .precision
                    cell.setSegment(self.precision)
                    cell.selectionStyle = .none
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: ConfigurationTVC.identifier, for: indexPath) as? ConfigurationTVC {
                    cell.configLabel.text = "Calculator Mode"
                    cell.delegate = self
                    cell.type = .calculation
                    cell.setSegment(self.calcMode)
                    cell.selectionStyle = .none
                    return cell
                }
            }

            return UITableViewCell()
        } else {
            let content = helpContent[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: HelpTVC.identifier, for: indexPath) as? HelpTVC {
                cell.cellImage.image = UIImage(systemName: "plus")
                cell.titleLabel.text = content["title"]
                cell.descriptionLabel.text = content["description"]
                cell.selectionStyle = .none
                return cell
            }
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch (indexPath.row) {
            case 0:
                showHelp(type: .savings)
            case 1:
                showHelp(type: .mortgate)
            case 2:
                showHelp(type: .loans)
            default:
                return
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

extension SettingsViewController: ConfigurationProtocol {
    func didChangeCalculationMode(_ mode: Calculate) {
        self.calcMode = mode
    }

    func didChangeCurrency(_ currency: Currency) {
        self.currency = currency
    }

    func didChangePrecision(_ precision: Precision) {
        self.precision = precision
    }
}
