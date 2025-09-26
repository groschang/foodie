//
//  ColorStyle.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ColorStyle: ShapeStyle {

    let lightColor: Color
    let darkColor: Color

    init(_ color: Color) {
        self.lightColor = color
        self.darkColor = color
    }

    init(_ colorStyle: ColorStyle) {
        self.init(
            light: colorStyle.lightColor,
            dark: colorStyle.darkColor
        )
    }

    init(
        light lightColor: @escaping @autoclosure () -> Color,
        dark darkColor: @escaping @autoclosure () -> Color
    ) {
        self.lightColor = lightColor()
        self.darkColor = darkColor()
    }

    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        environment.colorScheme == .light
        ? lightColor
        : darkColor
    }
}


extension ColorStyle: Hashable { }


@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension ColorStyle {
    func opacity(_ opacity: Double) -> ColorStyle {
        .init(
            light: lightColor.opacity(opacity),
            dark: darkColor.opacity(opacity)
        )
    }
}


extension ColorStyle {

    var color: Color {
        Color(light: lightColor, dark: darkColor)
    }
}
