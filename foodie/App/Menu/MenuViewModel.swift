//
//  MenuViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//

import SwiftUI

final class MenuViewModel: ObservableObject {

    @AppStorage(UserDefaultsKeys.appTheme) var appTheme: AppTheme = .system

    func setTheme(_ theme: AppTheme) {
        appTheme = theme
    }
}
