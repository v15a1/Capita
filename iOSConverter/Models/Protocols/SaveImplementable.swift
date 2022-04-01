//
//  SaveImplementable.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-04-01.
//

import Foundation

protocol SaveImplementable {
    func saveState()
    func restoreState()
}

extension SaveImplementable where Self: RootStatefulViewController {
    
    func saveState() {
        guard let stateKey = self.stateKey else {
            fatalError("Nil value for stateKey")
        }
        state.values[firstResponder!.tag] = firstResponder?.text ?? ""
        print(state)
        state.save(forKey: stateKey)
    }

    func restoreState() {
//        let values = textfields.reduce(into: [Int: String]()) {
//            $0[$1.tag] = ""
//        }
//
//        print(values)
//        state = SaveableState(values: values)
        guard let stateKey = self.stateKey else {
            fatalError("Nil value for stateKey")
        }
        if let savedState = SaveableState.getState(forKey: stateKey) {
            for (i, tf) in textfields.enumerated() {
                tf.text = savedState.values[i] ?? ""
            }
            state = savedState
        }
    }
}
