//
//  URL+Extensions.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-21.
//

import Foundation

extension UserDefaults {
    var loans: [Loan] {
        get {
            guard let data = UserDefaults.standard.data(forKey: K.Keys.SavedLoans) else { return [] }
            return (try? PropertyListDecoder().decode([Loan].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: K.Keys.SavedLoans)
        }
    }

    var savings: [Saving] {
        get {
            guard let data = UserDefaults.standard.data(forKey: K.Keys.SavedSavings) else { return [] }
            return (try? PropertyListDecoder().decode([Saving].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: K.Keys.SavedSavings)
        }
    }
}
