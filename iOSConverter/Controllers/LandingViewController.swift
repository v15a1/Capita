//
//  LandingViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    @IBAction func didPressActionButton(_ sender: Any) {
        dismiss(animated: true) {
            UserDefaults.standard.set(true, forKey: K.Keys.DidOnboard)
        }
    }
}
