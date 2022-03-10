//
//  Constants.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-02-24.
//

import UIKit

struct K {
    struct View {
        static let CornerRadius: CGFloat = 10
    }

    struct Storyboard {
        static let Main: String = "Main"
    }

    struct VC {
        static let ViewController: String = "ViewController"
    }

    struct Keys {
        static let AppTheme: String = "APP_THEME"
        static let Precision: String = "PRECISION"
        static let Currency: String = "CURRENCY"
        static let SavedSavingsState: String = "SAVING_STATE"
        static let SavedMortgageState: String = "MORTGAGE_STATE"

    }

    struct Segues {
        static let SavingsCalculation: String = "SavingsCalculation"
        static let MortgageCalculator: String = "MortgageCalculator"
        static let LoansCalculation: String = "LoansCalculation"
    }
}
