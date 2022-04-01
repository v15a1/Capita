//
//  SavedState.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import Foundation


struct SaveableState: Codable {
    var values: [Int: String]
}

extension SaveableState {
    func save(forKey: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            UserDefaults.standard.set(data, forKey: forKey)
        } catch {
            return
        }
    }

    static func getState(forKey: String) -> SaveableState? {
        if let data = UserDefaults.standard.data(forKey: forKey) {
            do {
                let decoder = JSONDecoder()
                let state = try decoder.decode(SaveableState.self, from: data)
                return state
            }
            catch {
                return nil
            }
        }
        return nil
    }
}
