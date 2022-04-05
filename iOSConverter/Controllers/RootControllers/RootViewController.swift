//
//  RootViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-04-02.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Raleway-Bold", size: 16)!
        ]

        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Raleway-Bold", size: 32)!
        ]
    }

}
