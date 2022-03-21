//
//  PersistenceController.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-03-21.
//

import Foundation

class PersistenceController {
    static let shared = PersistenceController()

    private init() {}

//    var loans: [Loan] {
//        get {
//            guard let data = try? Data(contentsOf: .loans) else { return [] }
//            return (try? JSONDecoder().decode([Loan].self, from: data)) ?? []
//        }
//        set {
//            try? JSONEncoder().encode(newValue).write(to: .domainSchemas)
//        }
//    }
    
}
