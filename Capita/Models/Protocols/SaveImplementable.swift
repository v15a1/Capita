//
//  SaveImplementable.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-04-01.
//

import Foundation

protocol SaveImplementable {
    func saveStateOnEdit()
    func saveState()
    func restoreState()
}


extension SaveImplementable where Self: RootStatefulViewController {

    func saveState() {
        guard let stateKey = self.stateKey else {
            fatalError("Nil value for stateKey")
        }

        textfields.forEach {
            state.values[$0.tag] = $0.text
        }
        state.save(forKey: stateKey) { [weak self] _, error in
            if let error = error {
                self?.showAlert(title: "Whoops!", message: "An error occured trying to save the state. Error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveStateOnEdit() {
        guard let stateKey = self.stateKey else {
            fatalError("Nil value for stateKey")
        }
        state.values[firstResponder!.tag] = firstResponder?.text ?? ""
        state.save(forKey: stateKey) { [weak self] _, error in
            if let error = error {
                self?.showAlert(title: "Whoops!", message: "An error occured trying to save the state. Error: \(error.localizedDescription)")
            }
             
        }
    }

    func restoreState() {
        guard let stateKey = self.stateKey else {
            fatalError("Nil value for stateKey")
        }

        if let savedState = SaveState.getState(forKey: stateKey), let tf = textfields.first(where: { $0.tag == savedState.emptyTFTag }) {
            emptyTextField = tf
            selectedParameterIndex = savedState.emptyTFTag ?? 0
            
            for (i, tf) in textfields.enumerated() {
                tf.text = savedState.values[i] ?? ""
            }
            state = savedState
        }
    }
}
