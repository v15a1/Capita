//
//  CalculationTVC.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import UIKit

class CalculationTVC: UITableViewCell {

    static let identifier = "CalculationTVC"

    @IBOutlet weak var holderImage: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.setGradient(colors: [.black, .clear])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
