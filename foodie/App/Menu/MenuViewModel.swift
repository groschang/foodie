//
//  MenuViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//

import Foundation
import UIKit

final class MenuViewModel: ObservableObject {

    
    func setTheme() {

    }
}







extension UserDefaults {

    enum CustomKeys: String {
        case AppTheme = "AppTheme"
    }

}


enum UserDefaultsKeys {

    static let appTheme = UserDefaults.CustomKeys.AppTheme.rawValue
}



import SwiftUI

enum AppTheme : String, Codable, CaseIterable {
    case system
    case light
    case dark
}

extension AppTheme {

    func colorScheme(system systemScheme: ColorScheme) -> ColorScheme {
        switch self {
        case .system:
            return systemScheme
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
