//
//  Extensions.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

// MARK: UIView Extensions
extension UIView {

    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        }
        else {
            return false
        }
    }

    /// Loads the UIView from the XIB (Nib is the more popular name. It stems from Swifts predecessor -- Objective-C)
    /// - Parameter nibName: Name of the XIB/Nib in string
    /// - Returns: The UIView corresponding to the given `nibName`
    func loadFromNib(_ nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    func setShadow(
        withColor color: UIColor,
        withAlpha alpha: Float = 1,
        withOffset offset: CGSize = .zero,
        withRadius radius: CGFloat = 10
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = alpha
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = true
    }

    func setGradient(colors: [UIColor], locations: [NSNumber] = [0.0, 1.0]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

// MARK: UIColor Extensions
extension UIColor {
    static let lightBlue: UIColor = UIColor(named: "LightBlue")!
    static let navyBlue: UIColor = UIColor(named: "NavyBlue")!
    static let lightGrey: UIColor = UIColor(named: "LightGrey")!
    static let CrayonBlue: UIColor = UIColor(named: "CrayonBlue")!
    static let CrayonPurple: UIColor = UIColor(named: "CrayonPurple")!
    static let CrayonPeach: UIColor = UIColor(named: "CrayonPeach")!
    static let Background: UIColor = UIColor(named: "Background")!

}

extension UIFont {
    static let ralewayLight: String = "Raleway-Light"
    static let ralewayMedium: String = "Raleway-Medium"
    static let ralewayRegular: String = "Raleway-Regular"
    static let ralewaySemiBold: String = "Raleway-SemiBold"
}

// MARK: UIStoryBoard
extension UIViewController {

    enum ViewControllerNames: String {
        case ViewController = "ViewController"
        case LandingViewController = "LandingViewController"
        case HelpViewController = "HelpViewController"
    }

    func loadFromStoryboard(_ withStoryboardName: String, vc: ViewControllerNames) -> UIViewController {
        let storyboard = UIStoryboard(name: withStoryboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: vc.rawValue)
    }

    func showAlert(title: String, message: String, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if let action = action {
                action()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlert(title: String, message: String, action: (() -> Void)? = nil, cancel: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if let action = action {
                action()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            if let cancel = cancel {
                cancel()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func showHelp(type: HelpScreenType) {
        if let vc = loadFromStoryboard(K.Storyboard.Tabbar, vc: .HelpViewController) as? HelpViewController {
            vc.screen = type
            present(vc, animated: true)
        }
    }
}

extension Array where Element: LabelledTextfield {

    func by(tag: Int) -> LabelledTextfield {
        return self.first(where: { $0.tag == tag})!
    }

    func valueByTag(tag: Int) -> Double? {
        if let element = self.first(where: { $0.tag == tag}) {
            return Double(element.inputTextfield.text!)
        }
        return nil
    }

    func getEmpty() -> LabelledTextfield? {
        if let tf = self.first(where: { $0.text.isEmpty  == true }) {
            return tf
        }
        return nil
    }

    func setText(_ text: String, forTag: Int) {
        if let element = self.first(where: { $0.tag == forTag}) {
            element.text = text
        }
    }
}


extension Double {
    func fixedTo(_ places: Int) -> Double {
        let divisor: Double = pow(10, Double(places))
        return (divisor * self).rounded() / divisor
    }
}

extension UIStackView {
    func clear() {
//        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
//            self.removeArrangedSubview(subview)
//            return allSubviews + [subview]
//        }
//        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
//        removedSubviews.forEach({ $0.removeFromSuperview() })
        self.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
