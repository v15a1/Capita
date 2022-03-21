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
        setupLoanHistory()
    }

    private func setupLoanHistory() {
        guard let data = persistable as? Loan else { return }
        typeLabel.text = "LOAN"
        typeView.backgroundColor = UIColor.CrayonPurple.withAlphaComponent(0.3)
        typeLabel.textColor = UIColor.CrayonPurple
        let content = [
            ["Loan Amount", "\(data.principleAmount)"],
            ["Interest (%)", "\(data.interestRate)"],
            ["Payment/mo", "\(data.monthlyPay)"],
            ["No. of Payments", "\(data.numOfPayments)"]
        ]

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
