//
//  AppTheme.swift
//  foodie
//
//  Created by Konrad Groschang on 02/01/2024.
//

import SwiftUI

extension UserDefaults {
    enum CustomKeys: String {
        case AppTheme = "AppTheme"
    }
}


enum UserDefaultsKeys {
    static let appTheme = UserDefaults.CustomKeys.AppTheme.rawValue
}

enum AppTheme : String, Codable, CaseIterable {
    case system
    case light
    case dark
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
