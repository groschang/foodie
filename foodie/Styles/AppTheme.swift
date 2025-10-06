//
//  AppTheme.swift
//  foodie
//
//  Created by Konrad Groschang on 02/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

extension UserDefaults {
    enum CustomKeys: String {
        case AppTheme = "AppTheme"
        case AppLanguage = "AppLanguage"
    }
}


enum UserDefaultsKeys {
    static let appTheme = UserDefaults.CustomKeys.AppTheme.rawValue
    static let appLanguage = UserDefaults.CustomKeys.AppLanguage.rawValue
}


enum AppTheme : String, Codable, CaseIterable {
    case system
    case light
    case dark
}


enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case german = "de"
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .english:
            return "English"
        case .german:
            return "Deutsch"
        }
    }
}


extension AppTheme {

    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}
