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

    var compoundSavings: [CompoundSaving] {
        get {
            guard let data = UserDefaults.standard.data(forKey: K.Keys.SavedCompoundSavings) else { return [] }
            return (try? PropertyListDecoder().decode([CompoundSaving].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: K.Keys.SavedCompoundSavings)
        }
    }
    
    var simpleSavings: [SimpleSaving] {
        get {
            guard let data = UserDefaults.standard.data(forKey: K.Keys.SavedSimpleSavings) else { return [] }
            return (try? PropertyListDecoder().decode([SimpleSaving].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: K.Keys.SavedSimpleSavings)
        }
    }
}
