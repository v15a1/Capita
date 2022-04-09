//
//  HelpTVC.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-09.
//

import UIKit

class HelpTVC: UITableViewCell {

    static let identifier: String = "HelpTVC"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptorLabel: UILabel!
    @IBOutlet weak var descriptorHolder: UIView!

    var title: String? {
        get {
            return titleLabel.text
        }
         
        set {
            titleLabel.text = newValue
        }
    }
    
    var content: String? {
        get {
            return descriptionLabel.text
        }
         
        set {
            descriptionLabel.text = newValue
        }
    }
    
    var descriptor: String? {
        get {
            return descriptorLabel.text
        }
         
        set {
            descriptorLabel.text = newValue
        }
    }
    
    var tint: UIColor? {
        get {
            return descriptorLabel.textColor
        }
         
        set {
            descriptorLabel.textColor = newValue
            descriptorHolder.backgroundColor = newValue?.withAlphaComponent(0.3)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        descriptorHolder.layer.cornerRadius = K.View.CornerRadius
    }

}
