//
//  SafeArea.swift
//  foodie
//
//  Created by Konrad Groschang on 07/01/2024.
//

import SwiftUI

extension View {

    var topSafeArea: CGFloat {

        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }

        guard let window = scene.windows.first else {
            return .zero
        }

        return window.safeAreaInsets.top
    }

}
