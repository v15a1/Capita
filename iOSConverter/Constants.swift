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
        static let Precision: String = "PRECISION"
        static let Currency: String = "CURRENCY"
        static let SavedSavingsState: String = "SAVING_STATE"
        static let SavedMortgageState: String = "MORTGAGE_STATE"
        static let SavedLoansState: String = "MORTGAGE_STATE"
        static let AutoCalculate: String = "AUTO_CALCULATE"

        static let SavedLoans: String = "SAVED_LOANS"

    }

    struct Segues {
        static let SavingsCalculation: String = "SavingsCalculation"
        static let MortgageCalculator: String = "MortgageCalculator"
        static let LoansCalculation: String = "LoansCalculation"
    }

    struct Content {
        static let LoanHelpContent: String = "This screen allows you to calculate the loan and corresponding payments based on the"
        static let SavingsHelpContent: String = "This screen allows you to calculate the interest required to return an amount for a future value for a fixed initial investment over a known period of time. \n\n• The application will automatically calculate the savings needed when 4 of the 5 values are provided \n"
//        static let LoanHelpContent: String = ""
    }
}
