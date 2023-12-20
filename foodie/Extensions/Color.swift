//
//  Color.swift
//  foodie
//
//  Created by Konrad Groschang on 07/04/2023.
//

import SwiftUI

//#if os(iOS)
//
//extension Color {
    

//    if #available(iOS 17, *) {

//        init(
//            light lightColor: @escaping @autoclosure () -> Color,
//            dark darkColor: @escaping @autoclosure () -> Color
//        ) {
//            self.init(
//        }
//
//    } else {
//      
//        func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
//            if environment.colorScheme == .light {
//                return lightColor
//            } else {
//                return darkColor
//            }
//        }
//
//    }



//}

//fileprivate struct CustomColorStyle: ShapeStyle {
//
//    let lightColor: Color
//    let darkColor: Color
//
//    init(
//        light lightColor: @escaping @autoclosure () -> Color,
//        dark darkColor: @escaping @autoclosure () -> Color
//    ) {
//        self.lightColor = lightColor()
//        self.darkColor = darkColor()
//    }
//
//    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
//        if environment.colorScheme == .light {
//            return lightColor
//        } else {
//            return darkColor
//        }
//    }
//}
//
//#else

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

//#endif
