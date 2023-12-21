//
//  AppStyle.swift
//  foodie
//
//  Created by Konrad Groschang on 07/04/2023.
//

import SwiftUI

struct AppStyle { }

extension Color {
    static let lightGray = Color(r: 214, g: 214, b: 214)
    static let darkGray = Color(r: 33, g: 33, b: 33)
}

extension AppStyle {
    static let white = ColorStyle(Color.white)
    static let lightGray = ColorStyle(Color.lightGray)
    static let gray = ColorStyle(Color.gray)
    static let darkGray = ColorStyle(Color.darkGray)
    static let black = ColorStyle(Color.black)
    static let blue = ColorStyle(Color.blue)
    static let orange = ColorStyle(Color.orange)
}

extension Color {
    static let light = Color.white
    static let lightWhite = Color.white.lightOpacity()
    static let darkWhite = Color.white.heavyOpacity()
    static let lightBlack = Color.black.lighterOpacity()
    static let darkBlack = Color.black.heaviestOpacity()
    static let darkBlue = Color.blue.heavyOpacity() //TODO: inver dark with light?
}

extension AppStyle {
    static let light = ColorStyle(Color.light)
    static let lightWhite = ColorStyle(Color.lightWhite)
    static let darkWhite = ColorStyle(Color.darkWhite)
    static let lightBlack = ColorStyle(Color.lightBlack)
    static let darkBlack = ColorStyle(Color.darkBlack)
    static let darkBlue = ColorStyle(Color.blue.heavyOpacity()) //TODO:
}

extension AppStyle {
    static let foreground = Self.black
    static let background = ColorStyle(light: Color.clear,
                                       dark: Color.darkBlack)
    static let accent = ColorStyle(light: Color.black,
                                   dark: Color.black)
    static let shadow = ColorStyle(light: Color.gray,
                                   dark: Color.lightGray)
}

extension Color {
    static let background = Color(light: AppStyle.background.lightColor,
                                  dark: AppStyle.background.darkColor) //TODO: find Color.background
    static let accent = Color(light: AppStyle.accent.lightColor,
                              dark: AppStyle.accent.darkColor)
    static let shadow =  Color(light: AppStyle.shadow.lightColor,
                               dark: AppStyle.shadow.darkColor)
}

extension AppStyle {
    static let main = Color.gray //TODO: check fixed bg color
}

extension AppStyle: View {
    var body: some View {
        Rectangle()
            .background(self)
    }
}

//TODO: make some preview!
