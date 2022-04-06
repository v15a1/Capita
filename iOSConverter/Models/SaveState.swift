//
//  SavedState.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-10.
//

import Foundation


struct SaveState: Codable {
    var values: [Int: String]
    var emptyTFTag: Int?
}

extension SaveState {
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
