//
//  RootStatefulViewController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import UIKit

class RootStatefulViewController: UIViewController {

    var isKeyboardOpen: Bool = false

    var state: SavedState!
    var stateKey: String!

    var firstResponder: LabelledTextfield?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showOnboardingIfNeeded() {
        if !UserDefaults.standard.bool(forKey: .didFirstLoad) {
            if let vc = self.loadFromStoryboard("Tabbar", vc: .LandingViewController) as? LandingViewController {
                present(vc, animated: true, completion: nil)
            }
        }
    }

    func saveState() {
        guard let stateKey = self.stateKey else {
            fatalError("Nil value for stateKey")
        }
        state.values[firstResponder!.tag] = firstResponder?.text ?? ""
        state.save(forKey: stateKey)
    }

    func restoreStateIfNeeded(_ textFields: [LabelledTextfield]) {
        let values = textFields.reduce(into: [Int: String]()) {
            $0[$1.tag] = ""
        }
        state = SavedState(values: values)
        guard let stateKey = self.stateKey else {
            fatalError("Nil value for stateKey")
        }
        if let savedState = SavedState.getState(forKey: stateKey) {
            for (i, tf) in textFields.enumerated() {
                tf.text = savedState.values[i] ?? ""
            }
        }
    }

}
