//
//  SavedState.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import Foundation


struct SavedState: Codable {
    var values: [Int: String]
}

extension SavedState {
    func save(forKey: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            UserDefaults.standard.set(data, forKey: forKey)
        } catch {
            print("Could not write SavedState obj: \(self)")
        }
    }

    static func getState(forKey: String) -> SavedState? {
        if let data = UserDefaults.standard.data(forKey: forKey) {
            do {
                let decoder = JSONDecoder()
                let state = try decoder.decode(SavedState.self, from: data)
                return state
            }
            catch {
                return nil
            }
        }
        return nil
    }
}
