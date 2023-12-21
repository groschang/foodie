//
//  ColorStyle.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
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
        self.init(light: colorStyle.lightColor,
                  dark: colorStyle.darkColor)
    }
    
    init(
        light lightColor: @escaping @autoclosure () -> Color,
        dark darkColor: @escaping @autoclosure () -> Color
    ) {
        self.lightColor = lightColor()
        self.darkColor = darkColor()
    }
    
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        environment.colorScheme == .light ? lightColor : darkColor
    }
}

