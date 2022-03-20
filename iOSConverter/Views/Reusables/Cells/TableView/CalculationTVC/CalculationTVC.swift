//
//  CalculationTVC.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import UIKit

class CalculationTVC: UITableViewCell {

    static let identifier = "CalculationTVC"
    static let height: CGFloat = 200

    @IBOutlet weak var holderImage: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!

    private lazy var slantedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = UIFont(name: UIFont.ralewaySemiBold, size: 100)
        label.frame = CGRect(x: 100, y: 100, width: 500, height: 200)
        label.transform = label.transform.rotated(by: .pi / 3)
        label.text = "Loans"
        return label
    }()

    var title: String? {
        willSet {
            titleLabel.text = newValue
            slantedLabel.text = newValue
        }
    }

    var contentDescriptor: String? {
        willSet {
            descriptionLabel.text = newValue
        }
    }

    var image: UIImage? {
        willSet {
            holderImage.image = newValue
        }
    }

    var tint: UIColor? {
        willSet {
            self.container.backgroundColor = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.layer.masksToBounds = true
        container.layer.cornerRadius = K.View.CornerRadius
        container.layer.masksToBounds = true
        holderView.addSubview(slantedLabel)
    }
    
}
