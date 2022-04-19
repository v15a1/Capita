//
//  UIView+Extensions.swift
//  Capita
//
//  Created by Visal Rajapakse on 2022-04-09.
//

import UIKit

// MARK: UIView Extensions
extension UIView {
    /// Loads the UIView from the XIB (Nib is the more popular name. It stems from Swifts predecessor -- Objective-C)
    /// - Parameter nibName: Name of the XIB/Nib in string
    /// - Returns: The UIView corresponding to the given `nibName`
    func loadFromNib(_ nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

// MARK: UIStackView extension
extension UIStackView {
    /// Clears the `UIStackView`
    func clear() {
        self.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

// MARK: UITableView Extensions
extension UITableView {
    /// Displays a message for empty `UITableViews`
    /// - Parameter message: Message to display
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .CrayonPeach
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: UIFont.ralewaySemiBold, size: 20)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
    }
}
