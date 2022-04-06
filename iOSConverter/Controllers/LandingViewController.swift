//
//  LandingViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit
import SwiftUI

class LandingViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.isModalInPresentation = true
//        self.view = UIHostingController(rootView: OnboardingView(action: {
//            self.dismiss(animated: true)
//        })).view
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func didPressActionButton(_ sender: Any) {
        dismiss(animated: true) {
//            UserDefaults.standard.set(true, forKey: K.Keys.DidOnboard)
        }
    }
}
