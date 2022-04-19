//
//  HistoryTVC.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-15.
//

import UIKit

class HistoryTVC: UITableViewCell {

    static let identifier: String = "HistoryTVC"

    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var contentVStack: UIStackView!
    @IBOutlet weak var contentHolder: UIView!
    @IBOutlet weak var createdAtLabel: UILabel!

    // Using Protocols as datatypes for generalization
    var persistable: Persistable!

    override func awakeFromNib() {
        super.awakeFromNib()
        typeLabel.transform = CGAffineTransform(rotationAngle: -.pi/2)
        contentHolder.backgroundColor = UIColor.lightGrey
        contentHolder.layer.cornerRadius = K.View.CornerRadius
        contentHolder.layer.masksToBounds = true

        layoutIfNeeded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentVStack.clear()
    }

    func setup(data: Persistable) {
        persistable = data
        // Setting data if possible
        setupLoanHistory()
        setupCompoundSavingHistory()
        setupSimpleSavingHistory()
        createdAtLabel.text = persistable.toDate()
    }

    // Sets up Compound saving history item
    private func setupCompoundSavingHistory() {
        guard let data = persistable as? CompoundSaving else { return }
        typeLabel.text = "COMPOUND"
        typeView.backgroundColor = UIColor.CrayonPeach.withAlphaComponent(0.3)
        typeLabel.textColor = UIColor.CrayonPeach
        let content = [
            ["Amount", "\(data.principleAmount)"],
            ["Interest (%)", "\(data.interestRate)"],
            ["Compounds/yr", "\(12)"],
            ["Future value", "\(data.futureValue)"],
            ["Terms", "\(data.terms)"],
            ["Payment", "\(data.payment)"]
        ]

        renderData(content)
    }
    
    // Sets up Simple saving history item
    private func setupSimpleSavingHistory() {
        guard let data = persistable as? SimpleSaving else {
            return
        }
        typeLabel.text = "SIMPLE"
        typeView.backgroundColor = UIColor.navyBlue.withAlphaComponent(0.3)
        typeLabel.textColor = UIColor.navyBlue
        let content = [
            ["Amount", "\(data.principleAmount)"],
            ["Interest (%)", "\(data.interestRate)"],
            ["Compounds/yr", "\(12)"],
            ["Future value", "\(data.futureValue)"],
            ["Terms", "\(data.terms)"]
        ]

        renderData(content)
    }
    
    // Sets up Loans history item
    private func setupLoanHistory() {
        guard let data = persistable as? Loan else { return }
        typeLabel.text = "LOAN"
        typeView.backgroundColor = UIColor.CrayonPurple.withAlphaComponent(0.3)
        typeLabel.textColor = UIColor.CrayonPurple
        let content = [
            ["Loan Amount", "\(data.principleAmount)"],
            ["Interest (%)", "\(data.interestRate)"],
            ["Payment/mo", "\(data.monthlyPay)"],
            ["Terms", "\(data.terms)"]
        ]

        renderData(content)
    }

    
    /// Renders the items based on the content
    /// - Parameter content: 2D array of the content
    private func renderData(_ content: [[String]]) {
        content.forEach { arr in
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.distribution = .equalCentering
            hStack.spacing = 20

            let title = UILabel()
            title.font = UIFont(name: UIFont.ralewaySemiBold, size: 14)
            title.text = arr[0]

            let value = UILabel()
            value.font = UIFont(name: UIFont.ralewayLight, size: 14)
            value.text = arr[1]

            hStack.addArrangedSubview(title)
            hStack.addArrangedSubview(value)
            contentVStack.addArrangedSubview(hStack)
        }
    }
}
