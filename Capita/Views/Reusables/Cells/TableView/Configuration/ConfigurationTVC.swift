//
//  PrecisionTVC.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-09.
//

import UIKit

enum Precision: Int {
    case low = 1
    case medium = 3
    case high = 7
}

enum Currency: String {
    case lkr = "රු"
    case usd = "$"
    case gbp = "£"

    static var selected: String {
        return UserDefaults.standard.string(forKey: K.Keys.Currency) ?? Currency.usd.rawValue
    }
}

enum Calculate: String {
    case auto = "Auto"
    case manual = "Manual"
}

enum ConfigurationType {
    case none
    case currency
    case precision
    case calculation
}

protocol ConfigurationProtocol: AnyObject {
    func didChangePrecision(_ precision: Precision)
    func didChangeCurrency(_ currency: Currency)
    func didChangeCalculationMode(_ mode: Calculate)
}

class ConfigurationTVC: UITableViewCell {

    static let identifier = "ConfigurationTVC"
    
    var type: ConfigurationType = .none {
        didSet {
            switch type {
            case .currency:
                setupCurrency()
            case .precision:
                setupPrecision()
            case .calculation:
                setupCalculationSetting()
            case .none:
                return
            }
        }
    }

    weak var delegate: ConfigurationProtocol?

    @IBOutlet weak var configSegmentController: UISegmentedControl!
    @IBOutlet weak var configLabel: UILabel!
    @IBOutlet weak var holder: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        holder.layer.cornerRadius = K.View.CornerRadius
    }

    private func setupCurrency() {
        configSegmentController.setTitle(Currency.lkr.rawValue, forSegmentAt: 0)
        configSegmentController.setTitle(Currency.usd.rawValue, forSegmentAt: 1)
        configSegmentController.setTitle(Currency.gbp.rawValue, forSegmentAt: 2)
    }

    private func setupPrecision() {
        configSegmentController.setTitle("Low", forSegmentAt: 0)
        configSegmentController.setTitle("Medium", forSegmentAt: 1)
        configSegmentController.setTitle("High", forSegmentAt: 2)
    }

    private func setupCalculationSetting() {
        configSegmentController.removeSegment(at: 2, animated: false)
        configSegmentController.setTitle(Calculate.auto.rawValue, forSegmentAt: 0)
        configSegmentController.setTitle(Calculate.manual.rawValue, forSegmentAt: 1)
    }

    func setSegment(_ calculationMode: Calculate) {
        switch (calculationMode) {
        case .auto:
            configSegmentController.selectedSegmentIndex = 0
        case .manual:
            configSegmentController.selectedSegmentIndex = 1
        }
    }

    func setSegment(_ precision: Precision) {
        switch (precision) {
        case .low:
            configSegmentController.selectedSegmentIndex = 0
        case .medium:
            configSegmentController.selectedSegmentIndex = 1
        case .high:
            configSegmentController.selectedSegmentIndex = 2
        }
    }

    func setSegment(_ currency: Currency) {
        switch (currency) {
        case .lkr:
            configSegmentController.selectedSegmentIndex = 0
        case .usd:
            configSegmentController.selectedSegmentIndex = 1
        case .gbp:
            configSegmentController.selectedSegmentIndex = 2

        }
    }

    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        let currency: Currency!
        let precision: Precision!
        let calculator: Calculate!

        if sender.selectedSegmentIndex == 0 {
            currency = .lkr
            precision = .low
            calculator = .auto
        } else if sender.selectedSegmentIndex == 1 {
            currency = .usd
            precision = .medium
            calculator = .manual
        } else {
            currency = .gbp
            precision = .high
            calculator = .none
        }

        switch type {
        case .currency:
            delegate?.didChangeCurrency(currency)
        case .precision:
            delegate?.didChangePrecision(precision)
        case .calculation:
            delegate?.didChangeCalculationMode(calculator)
        case .none:
            return
        }

    }


}
