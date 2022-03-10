//
//  SettingsViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-09.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!

    var precision: Precision!
    var currency: Currency!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(currency.rawValue, forKey: K.Keys.Currency)
        UserDefaults.standard.set(precision.rawValue, forKey: K.Keys.Precision)
    }

    private func setup() {
        title = "Settings"

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.allowsSelection = false
        settingsTableView.separatorStyle = .none
        settingsTableView.register(UINib(nibName: HelpTVC.identifier, bundle: nil), forCellReuseIdentifier: HelpTVC.identifier)
        settingsTableView.register(UINib(nibName: ConfigurationTVC.identifier, bundle: nil), forCellReuseIdentifier: ConfigurationTVC.identifier)


        precision = Precision(rawValue: UserDefaults.standard.integer(forKey: K.Keys.Precision)) ?? .high
        currency = Currency(rawValue: UserDefaults.standard.string(forKey: K.Keys.Currency) ?? "LKR")
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
            return 2
        } else {
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: ConfigurationTVC.identifier, for: indexPath) as? ConfigurationTVC {
                    cell.configLabel.text = "Precision"
                    cell.delegate = self
                    cell.setSegment(self.precision)
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: ConfigurationTVC.identifier, for: indexPath) as? ConfigurationTVC {
                    cell.configLabel.text = "Currency"
                    cell.delegate = self
                    cell.isCurrency = true
                    cell.setSegment(self.currency)
                    return cell
                }
            }

            return UITableViewCell()
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: HelpTVC.identifier, for: indexPath) as? HelpTVC {
                return cell
            }
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

extension SettingsViewController: ConfigurationProtocol {
    func didChangeCurrency(_ currency: Currency) {
        self.currency = currency
    }

    func didChangePrecision(_ precision: Precision) {
        self.precision = precision
    }
}
