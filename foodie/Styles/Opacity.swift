//
//  Opacity.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//

import SwiftUI

struct Opacity {
    static let light: CGFloat = 0.85
    static let lightMedium: CGFloat = 0.65
    static let medium: CGFloat = 0.5
    static let heavy: CGFloat = 0.2
    static let veryHeavy: CGFloat = 0.12
}

protocol Opacitiable {
    associatedtype T
    func opacity(_ opacity: Double) -> T
}

//extension Opacitiable {
//
//    func lightestOpacity() -> T { opacity(Opacity.light) }
//    func lightOpacity() -> T { opacity(Opacity.lightMedium) }
//    func mediumOpacity() -> T { opacity(Opacity.medium) }
//    func darkOpacity() -> T { opacity(Opacity.heavy) }
//    func heaviestOpacity() -> T { opacity(Opacity.veryHeavy) }
//}

//extension Color: Opacitiable { }
//extension ShapeStyle: Opacitiable { }
//extension View: Opacitiable { }


extension View where Self == Color {

    func lighterOpacity() -> Self { opacity(Opacity.light) }
    func lightOpacity() -> Self { opacity(Opacity.lightMedium) }
    func mediumOpacity() -> Self { opacity(Opacity.medium) }
    func heavyOpacity() -> Self { opacity(Opacity.heavy) }
    func heaviestOpacity() -> Self { opacity(Opacity.veryHeavy) }
}

//extension ShapeStyle where Self == ColorStyle {
//
//    func lighterOpacity() -> some ShapeStyle { opacity(Opacity.light) }
//    func lightOpacity() -> some ShapeStyle { opacity(Opacity.lightMedium) }
//    func mediumOpacity() -> some ShapeStyle { opacity(Opacity.medium) }
//    func heavyOpacity() -> some ShapeStyle { opacity(Opacity.heavy) }
//    func heaviestOpacity() -> some ShapeStyle { opacity(Opacity.veryHeavy) }
//}

extension ColorStyle {

    func lighterOpacity() -> Self { opacity(Opacity.light) as! ColorStyle }
    func lightOpacity() -> Self { opacity(Opacity.lightMedium) as! ColorStyle }
    func mediumOpacity() -> Self { opacity(Opacity.medium) as! ColorStyle }
    func heavyOpacity() -> Self { opacity(Opacity.heavy) as! ColorStyle }
    func heaviestOpacity() -> Self { opacity(Opacity.veryHeavy) as! ColorStyle }
}

extension View {

    func lighterOpacity() -> some View { opacity(Opacity.light) }
    func lightOpacity() -> some View { opacity(Opacity.lightMedium) }
    func mediumOpacity() -> some View { opacity(Opacity.medium) }
    func heavyOpacity() -> some View { opacity(Opacity.heavy) }
    func heaviestOpacity() -> some View { opacity(Opacity.veryHeavy) }
}

