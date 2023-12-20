//
//  Colors.swift
//  foodie
//
//  Created by Konrad Groschang on 07/04/2023.
//

import SwiftUI

struct ColorStyle {

    //TODO: dark & light should be relative, white, black constant

    static let blue = Color(light: Color.blue, dark: Color.blue)

    static let gray = Color.gray
    static let dark = Color.black
    static let black = Color(light: Color.black, dark: Color.white)

    static let white = Color(light: Color.white, dark: Color.black)
    static let light = Color.white
    static let lightWhite = Color.white.lightMediumOpacity()

    static let orange = Color.orange
}

extension ColorStyle {

    static let background = Color(light: Color.clear,
                                  dark: Color.red.veryHeavyOpacity())

    static let accent = Color(light: ColorStyle.black,
                              dark: ColorStyle.black)

    static let shadow = Color(light: ColorStyle.gray,
                              dark: ColorStyle.gray)
}

extension ColorStyle {

    static let backButton = Color.red
}

extension ColorStyle {

    static let appColor = Color.gray

    static let foreground = Color.black
}


struct Opacity {
    static let light: CGFloat = 0.85
    static let lightMedium: CGFloat = 0.65
    static let medium: CGFloat = 0.5
    static let heavy: CGFloat = 0.2
    static let veryHeavy: CGFloat = 0.1
}

extension View {

    func lightOpacity() -> some View { opacity(Opacity.light) }

    func lightMediumOpacity() -> some View { opacity(Opacity.lightMedium) }

    func mediumOpacity() -> some View { opacity(Opacity.medium) }

    func heavyOpacity() -> some View { opacity(Opacity.heavy) }

    func veryHeavyOpacity() -> some View { opacity(Opacity.veryHeavy) }
}

extension View where Self == Color {

    func lightOpacity() -> Self { opacity(Opacity.light) }

    func lightMediumOpacity() -> Self { opacity(Opacity.lightMedium) }

    func mediumOpacity() -> Self { opacity(Opacity.medium) }

    func heavyOpacity() -> Self { opacity(Opacity.heavy) }

    func veryHeavyOpacity() -> Self { opacity(Opacity.veryHeavy) }
}
