//
//  Opacity.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct Opacity {
    static let light: CGFloat = 0.85
    static let lightMedium: CGFloat = 0.65
    static let medium: CGFloat = 0.5
    static let heavy: CGFloat = 0.35
    static let heavier: CGFloat = 0.2
    static let heaviest: CGFloat = 0.12
}

extension View where Self == Color {

    func lighterOpacity() -> Self { opacity(Opacity.light) }
    func lightOpacity() -> Self { opacity(Opacity.lightMedium) }
    func mediumOpacity() -> Self { opacity(Opacity.medium) }
    func heavyOpacity() -> Self { opacity(Opacity.heavy) }
    func heavierOpacity() -> Self { opacity(Opacity.heavier) }
    func heaviestOpacity() -> Self { opacity(Opacity.heaviest) }
}

extension ColorStyle {

    func lighterOpacity() -> Self { opacity(Opacity.light) }
    func lightOpacity() -> Self { opacity(Opacity.lightMedium) }
    func mediumOpacity() -> Self { opacity(Opacity.medium) }
    func heavyOpacity() -> Self { opacity(Opacity.heavy) }
    func heavierOpacity() -> Self { opacity(Opacity.heavier) }
    func heaviestOpacity() -> Self { opacity(Opacity.heaviest) }
}

extension View {

    func lighterOpacity() -> some View { opacity(Opacity.light) }
    func lightOpacity() -> some View { opacity(Opacity.lightMedium) }
    func mediumOpacity() -> some View { opacity(Opacity.medium) }
    func heavyOpacity() -> some View { opacity(Opacity.heavy) }
    func heavierOpacity() -> some View { opacity(Opacity.heavier) }
    func heaviestOpacity() -> some View { opacity(Opacity.heaviest) }
}

