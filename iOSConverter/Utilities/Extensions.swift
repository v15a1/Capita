//
//  Extensions.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
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
}

// MARK: UIStoryBoard
extension UIViewController {

    enum ViewControllerNames: String {
        case ViewController = "ViewController"
        case LandingViewController = "LandingViewController"
    }

    func loadFromStoryboard(_ withStoryboardName: String, vc: ViewControllerNames) -> UIViewController {
        let storyboard = UIStoryboard(name: withStoryboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: vc.rawValue)
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: UIFont Extensions
extension String {
    static let didFirstLoad: String = "DID_FIRST_LOAD"
}

extension AppDelegate {

    enum Theme: Int {
        case light = 1
        case dark = 2
        case system = 3
    }

    func overrideApplicationThemeStyle() {
        let persistedTheme = UserDefaults.standard.integer(forKey: K.Keys.AppTheme)
        let theme = Theme(rawValue: persistedTheme)

        if theme == .system {

        } else {
            let window = UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
            window?.overrideUserInterfaceStyle = (theme == Theme.dark) ? .dark : .light
        }
    }
}

extension Array where Element: LabelledTextfield {
    func valueByTag(tag: Int) -> Double? {
        if let element = self.first(where: { $0.tag == tag}) {
            return Double(element.inputTextfield.text!)
        }
        return nil
    }

    func setText(_ text: String, forTag: Int) {
        if let element = self.first(where: { $0.tag == forTag}) {
            element.text = text
        }
    }
}
