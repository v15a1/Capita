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
    case lkr = "LKR"
    case usd = "USD"
    case gbp = "GBP"
}

protocol ConfigurationProtocol: AnyObject {
    func didChangePrecision(_ precision: Precision)
    func didChangeCurrency(_ currency: Currency)

}

class ConfigurationTVC: UITableViewCell {

    static let identifier = "ConfigurationTVC"
    
    var isCurrency = false {
        didSet {
            if isCurrency {
                setupCurrency()
            } else {
                setupPrecision()
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

        if sender.selectedSegmentIndex == 0 {
            currency = .lkr
            precision = .low
        } else if sender.selectedSegmentIndex == 1 {
            currency = .usd
            precision = .medium
        } else {
            currency = .gbp
            precision = .high
        }

        if isCurrency {
            delegate?.didChangeCurrency(currency)
        } else {
            delegate?.didChangePrecision(precision)
        }

    }


}
