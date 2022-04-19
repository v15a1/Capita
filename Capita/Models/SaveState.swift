//
//  SavedState.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import Foundation

/// Data to store as Text field states
struct SaveState: Codable {
    var values: [Int: String]
    var emptyTFTag: Int?
}

extension SaveState {
    
    /// Saves the current state of the textfields
    /// - Parameters:
    ///   - forKey: Key to save to
    ///   - action: Callback for events
    func save(forKey: String, action: ((Bool, Error?) -> ())? = nil) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            UserDefaults.standard.set(data, forKey: forKey)
            action?(true, nil)
        } catch {
            action?(false, error)
        }
    }
    
    /// Retrieving the state
    /// - Parameter forKey: Key to retrieve state from
    /// - Returns: Saved state
    static func getState(forKey: String) -> SaveState? {
        if let data = UserDefaults.standard.data(forKey: forKey) {
            do {
                let decoder = JSONDecoder()
                let state = try decoder.decode(SaveState.self, from: data)
                return state
            }
            catch {
                return nil
            }
        }
        return nil
    }
}
