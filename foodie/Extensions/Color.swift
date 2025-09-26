//
//  Color.swift
//  foodie
//
//  Created by Konrad Groschang on 07/04/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color {

    init(
        light lightColor: @escaping @autoclosure () -> Color,
        dark darkColor: @escaping @autoclosure () -> Color
    ) {
        self.init(
            UIColor(
                light: UIColor( lightColor() ),
                dark: UIColor( darkColor() )
            )
        )
    }
}


extension UIColor {

    convenience init(
        light lightColor: @escaping @autoclosure () -> UIColor,
        dark darkColor: @escaping @autoclosure () -> UIColor
    ) {
        self.init { traitCollection in
            var colorMode: UIColor

            switch traitCollection.userInterfaceStyle {
            case .light:
                colorMode = lightColor()
            case .dark:
                colorMode = darkColor()
            case .unspecified:
                colorMode = lightColor()
            @unknown default:
                colorMode = lightColor()
            }

            return colorMode
        }
    }
}


extension Color {

    var components: (red: Int, green: Int, blue: Int, opacity: CGFloat) {

    #if canImport(UIKit)
        typealias NativeColor = UIColor
    #elseif canImport(AppKit)
        typealias NativeColor = NSColor
    #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            return (0, 0, 0, 0)
        }

        return (
            Int(r * 255),
            Int(g * 255),
            Int(b * 255),
            o
        )
    }

    var hex: String {
        String(
            format: "#%02x%02x%02x%02x",
            Int(components.red * 255),
            Int(components.green * 255),
            Int(components.blue * 255),
            Int(components.opacity * 255)
        )
    }
}


extension Color {

    init(r: Int, g: Int, b: Int) {
        assert( 0 <= r, "Red value must be greater than 0, current value: \(r)")
        assert( r <= 255, "Red value must be less than 255, current value: \(r)")

        assert( 0 <= g, "Green value must be greater than 0, current value: \(g)")
        assert( g <= 255, "Green value must be less than 255, current value: \(g)")

        assert( 0 <= b, "Blue value must be greater than 0, current value: \(b)")
        assert( b <= 255, "Blue value must be less than 255, current value: \(b)")

        let red = Double( r ) / 255
        let green = Double( g ) / 255
        let blue = Double( b ) / 255

        self = .init(red: red, green: green, blue: blue)
    }
}


extension Color {

    var brightness: Double {
        let (red, green, blue, opacity) = components
        let average = Double( red + green + blue ) / 3.0
        let relative = average / 255.0
        return max(relative, 1 - opacity)
    }

    var isBright: Bool {
        brightness > 0.6
    }
}
