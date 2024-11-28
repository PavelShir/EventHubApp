//
//  Constants.swift
//  EventHub
//
//  Created by Павел Широкий on 20.11.2024.
//

import UIKit

struct Constants {
    
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    struct Authorization {
        static let loginTitle: String = "Welcome Back 👋"
        static let loginDescription: String = "Sing In"
        static let registerTitle: String = "Sing Up"
        static let registerDescription: String = ""
        static let placeholderEmail: String = "Email"
        static let placeholderPassword: String = "Password"
        static let placeholderRepeatPassword: String = "Repeat Password"
        static let placeholderName: String = "Full name"
        static let signInButtonTitle: String = "Sing in"
        static let signUpButtonTitle: String = "Sing up"
        static let signInLabel: String = "Already have an account?"
        static let signUpLabel: String = "Don't have an account?"
        
        
        // Relative sizez
        static var fontSizeTitleLabel: CGFloat { Constants.screenWidth * (24 / 375) }
        static var fontSizeDescriptionLabel: CGFloat { Constants.screenWidth * (24 / 375) }
        static var cornerRadiusSignButton: CGFloat { Constants.screenHeight * (12 / 812) }
        static var spacingStackView: CGFloat { Constants.screenWidth * (5 / 375) }
        static var fontSizeSign: CGFloat { Constants.screenWidth * (16 / 375) }
        static var topMarginTitleLabel: CGFloat { Constants.screenHeight * (72 / 812) }
        static var topMarginDescriptionLabel: CGFloat { Constants.screenHeight * ( 8 / 812) }
        static var horizontalMarginTwenty: CGFloat { Constants.screenWidth * (20 / 375) }
        static var horizontalMarginSingInButton: CGFloat { Constants.screenWidth * (42 / 375) }
        static var topMarginUpperTextField: CGFloat { Constants.screenHeight * (32 / 812) }
        static var topMarginInteriorTextField: CGFloat { Constants.screenHeight * (16 / 812) }
        static var heightTextField: CGFloat { Constants.screenHeight * (56 / 812) }
        static var topMarginSignButton: CGFloat { Constants.screenHeight * (64 / 812) }
        static var heightSignButton: CGFloat { Constants.screenHeight * (56 / 812) }
        static var bottomMarginStackView: CGFloat { Constants.screenHeight * (42 / 812) }
        static var rightMarginToggleButton: CGFloat { Constants.screenWidth * (16 / 375) }
        static var heightToggleButton: CGFloat { Constants.screenHeight * (24 / 812) }
    }
    
    struct allColors {
        static let primaryButtonBlue = "mainBlue"
        static let darkBlue = "darkBlue"
        static let darkRed = "darkRed"
        static let primaryBlue = "primaryBlue"
        static let whiteBackground = "whiteBackground"
        
        static let darkText = "darkText"
        static let lightText = "lightText"
        static let whiteText = "whiteText"
        
    }
    
}


