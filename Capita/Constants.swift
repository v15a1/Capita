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
        static let Tabbar: String = "Tabbar"
    }

    struct VC {
        static let ViewController: String = "ViewController"
        static let HelpViewController: String = "HelpViewController"
    }

    struct Keys {
        static let DidOnboard: String = "ONBOARD"
        static let Currency: String = "CURRENCY"
        
        static let SavedSavingsState: String = "SAVING_STATE"
        static let SavedMortgageState: String = "MORTGAGE_STATE"
        static let SavedLoansState: String = "MORTGAGE_STATE"

        static let SavedLoans: String = "SAVED_LOANS"
        static let SavedCompoundSavings: String = "SAVED_C_SAVINGS"
        static let SavedSimpleSavings: String = "SAVED_S_SAVINGS"

    }

    struct Segues {
        static let SavingsCalculation: String = "SavingsCalculation"
        static let MortgageCalculator: String = "MortgageCalculator"
        static let LoansCalculation: String = "LoansCalculation"
    }

    struct Content {
        static let LoanHelpContent: String = "This calculator determines your mortgage payment and provides you with a mortgage payment schedule. The calculator also shows how much money and how many years you can save by making prepayments.\n\n• The application will automatically calculate the savings needed when 3 of the 4 values are provided \n"
        static let CompoundSavingsHelpContent: String = "This screen allows you to calculate the interest required to return an amount for a future value for a fixed initial investment over a known period of time. \n\n• The application will automatically calculate the savings needed when 4 of the 5 values are provided \n"
        static let SimpleSavingsHelpContent: String = "Use this free savings calculator to estimate your investment growth over time. Work out the interest on your IRA, calculate certificates of deposit growth or estimate how long it will take to save for a down payment on a house. With this growth calculator, you can set a goal and figure out how much you need to save each month to hit the mark.\n\n• The application will automatically calculate the savings needed when 3 of the 4 values are provided, given that a parameter to calculate has been selected."
    }
}
