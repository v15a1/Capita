//
//  Extensions.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

// MARK: UIViewController
extension UIViewController {

    enum ViewControllerNames: String {
        case ViewController = "ViewController"
        case LandingViewController = "LandingViewController"
        case HelpViewController = "HelpViewController"
    }

    /// Loads Storyboard/VC
    func loadFromStoryboard(_ withStoryboardName: String, vc: ViewControllerNames) -> UIViewController {
        let storyboard = UIStoryboard(name: withStoryboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: vc.rawValue)
    }

    /// Shows Alert with a single action and a single callback
    func showAlert(title: String, message: String, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            action?()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    /// Shows Alert with a cancel action and two callbacks for each of the buttons
    func showAlert(title: String, message: String, action: (() -> Void)? = nil, cancel: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            action?()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            cancel?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Presents Help modal view
    func showHelp(type: CalculationType) {
        if let vc = loadFromStoryboard(K.Storyboard.Calculations, vc: .HelpViewController) as? HelpViewController {
            vc.screen = type
            present(vc, animated: true)
        }
    }
}
