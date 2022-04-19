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
        ["descriptor": "C", "title": "Compound savings", "description": "Help regarding compound savings"],
        ["descriptor": "S", "title": "Simple savings", "description": "Help regarding simple savings"],
        ["descriptor": "L", "title": "Loans", "description": "Help regarding loans"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(currency.rawValue, forKey: K.Keys.Currency)
    }

    private func setup() {
        title = "Settings"

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.separatorStyle = .none
        settingsTableView.register(UINib(nibName: HelpTVC.identifier, bundle: nil), forCellReuseIdentifier: HelpTVC.identifier)
        settingsTableView.register(UINib(nibName: ConfigurationTVC.identifier, bundle: nil), forCellReuseIdentifier: ConfigurationTVC.identifier)

        currency = Currency(rawValue: UserDefaults.standard.string(forKey: K.Keys.Currency) ?? "") ?? .usd
    }
}

// MARK: UITableView Ext.
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
            return 1
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
            }
            return UITableViewCell()
        } else {
            let content = helpContent[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: HelpTVC.identifier, for: indexPath) as? HelpTVC {
                cell.title = content["title"]
                cell.content = content["description"]
                cell.descriptor = content["descriptor"]
                if indexPath.row == 0 {
                    cell.tint = UIColor.CrayonPeach
                } else if indexPath.row == 1 {
                    cell.tint = UIColor.CrayonBlue
                } else {
                    cell.tint = UIColor.CrayonPurple
                }
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
                showHelp(type: .compoundSaving)
            case 1:
                showHelp(type: .simpleSaving)
            case 2:
                showHelp(type: .loan)
            default:
                return
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

// MARK: ConfigurationDelegate Ext.
extension SettingsViewController: ConfigurationDelegate {
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
