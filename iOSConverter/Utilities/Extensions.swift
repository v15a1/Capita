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
