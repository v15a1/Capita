//
//  HelpTVC.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-09.
//

import UIKit

class HelpTVC: UITableViewCell {

    static let identifier: String = "HelpTVC"

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        // unused
    }

}
