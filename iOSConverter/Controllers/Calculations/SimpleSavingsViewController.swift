//
//  MortgageViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import UIKit

class SimpleSavingsViewController: RootStatefulViewController {

    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }

    private func setup() {
        stateKey = K.Keys.SavedLoansState
    }
}
