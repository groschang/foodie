//
//  AppStyle.swift
//  foodie
//
//  Created by Konrad Groschang on 07/04/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
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

@MainActor
extension Color {
    static let light = Color.white
    static let lightWhite = Color.white.lightOpacity()
    static let darkWhite = Color.white.heavierOpacity()
    static let lightBlack = Color.black.lighterOpacity()
    static let darkBlack = Color.black.heaviestOpacity()
    static let darkBlue = Color.blue.heavierOpacity() //TODO: inver dark with light?
}

@MainActor
extension AppStyle {
    static let light = ColorStyle(Color.light)
    static let lightWhite = ColorStyle(Color.lightWhite)
    static let darkWhite = ColorStyle(Color.darkWhite)
    static let lightBlack = ColorStyle(Color.lightBlack)
    static let darkBlack = ColorStyle(Color.darkBlack)
    static let darkBlue = ColorStyle(Color.blue.heavierOpacity()) //TODO:
}

extension AppStyle {
    static let foreground = ColorStyle(light: Color.black,
                                       dark: Color.white)
    static let background = ColorStyle(light: Color.clear,
                                       dark: Color.darkGray)
    static let accent = ColorStyle(light: Color.black,
                                   dark: Color.white)
    static let shadow = ColorStyle(light: Color.gray,
                                   dark: Color.gray)
    static let toolbar = ColorStyle(light: Color.gray,
                                    dark: Color.gray)
}

@MainActor
extension Color {
    static let foreground = Color(light: AppStyle.foreground.lightColor,
                                  dark: AppStyle.foreground.darkColor)
    static let background = Color(light: AppStyle.background.lightColor,
                                  dark: AppStyle.background.darkColor) //TODO: find Color.background
    static let accent = Color(light: AppStyle.gray.lightColor,
                              dark: AppStyle.white.darkColor)
    static let shadow = Color(light: AppStyle.shadow.lightColor.mediumOpacity(),
                               dark: AppStyle.shadow.darkColor.mediumOpacity())
    static let toolbar = Color(light: AppStyle.toolbar.lightColor,
                                dark: AppStyle.toolbar.darkColor)
}

extension AppStyle {
    static let main = Color.gray //TODO: check fixed bg color
}

extension AppStyle {
    static var cornerRadius: CGFloat { 20.0 }
    static var shadowRadius: CGFloat { 8.0 }
}

extension AppStyle {

    struct Animations {
        static let transition: Animation = .spring(response: 0.6, dampingFraction: 0.8)
    }
}


// MARK: Previews

@MainActor
extension AppStyle {

    /// Return all color styles defined in the `AppStyle`
    ///
    /// This could be enum (structure `ColorStyle` as well as `AppStyle`) with case iterable but that would force accessing `rawValue` or desired property `value`
    ///
    /// Another idea is to use Mirror and reflection mechanism but class members are not supported
    ///
    /// Implementation below presents programmatically created extension that returns iterable colors styles array
    static let all: [ColorStyle] = [
        /// casted colors
        AppStyle.white,
        AppStyle.lightGray,
        AppStyle.gray,
        AppStyle.darkGray,
        AppStyle.black,
        AppStyle.blue,
        AppStyle.orange,
        /// relative
        AppStyle.light,
        AppStyle.lightWhite,
        AppStyle.darkWhite,
        AppStyle.lightBlack,
        AppStyle.darkBlack,
        AppStyle.darkBlue,
        /// styles
        AppStyle.foreground,
        AppStyle.background,
        AppStyle.accent,
        AppStyle.shadow
    ]
}

@MainActor
extension Color {

    /// Return all colors defined in the `AppStyle`
    ///
    /// This could be enum (i.e. structure `Colors`) with case iterable but that would force accessing `rawValue` or desired property `value`
    ///
    /// Another idea is to use Mirror and reflection mechanism but class members are not supported
    ///
    /// Implementation below presents programmatically created extension that returns iterable colors array
    static let all: [Color] = [
        /// defined
        .lightGray,
        .darkGray,
        /// relative
        .light,
        .lightWhite,
        .darkWhite,
        .lightBlack,
        .darkBlack,
        .darkBlue,
        /// styles
        .foreground,
        .background,
        .accent,
        .shadow
    ]

}

#Preview {
    List {
        
        DebugSection("AppStyles") {
            ForEach(AppStyle.all, id: \.self) {
                ColorStyleDebugView($0)
            }
        }

        DebugSection("Custom colors") {
            ForEach(Color.all, id: \.self) {
                ColorDebugView($0)
            }
        }

        DebugSection("Colors test") {
            ColorDebugView(color: Color.gray)
            ColorStyleDebugView(style: AppStyle.gray)
            ColorStyleDebugView(style: AppStyle.darkBlue)
            ColorStyleDebugView(style: AppStyle.shadow)
            ColorStyleDebugView(style: AppStyle.background)
            ColorStyleDebugView(style: AppStyle.blue.opacity(0.5))
            ColorStyleDebugView(style: AppStyle.darkBlue)
            ColorStyleDebugView(style: AppStyle.blue.heaviestOpacity())
        }
    }
    .listStyle(.insetGrouped)
}
