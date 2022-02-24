//
//  LandingCVC.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class LandingCVC: UICollectionViewCell {

    static let Identifier: String = "LandingCVC"

    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = K.View.CornerRadius
        // Initialization code
    }

}
