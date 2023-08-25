//
//  MealListView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import SwiftUI

struct MealListStyle: ViewModifier {

    private struct Colors {
        static let background = ColorStyle.white
    }

    private struct Shadow {
        static let radius = 4.0
        static let color = ColorStyle.shadow.heavyOpacity()
    }

    private struct Layouts {
        static let width = Double.infinity
        static let height = 50.0
        static let radius = 8.0
    }

    private struct Paddings {
        static let vertical = 8.0
        static let horizontal = 16.0
    }

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: Layouts.width, minHeight: Layouts.height)
            .background(Colors.background)
            .cornerRadius(Layouts.radius)
            .shadow(color: Shadow.color, radius: Shadow.radius)
    }
}

struct MealListPhotoStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(ListPhotoStyle())
    }
}

struct MealListNameStyle: ViewModifier {

    private struct Colors {
        static let foreground = ColorStyle.black
    }

    private struct Shadow {
        static let radius = 1.0
        static let color = ColorStyle.white.heavyOpacity()
    }

    func body(content: Content) -> some View {
        content
            .foregroundColor(Colors.foreground)
            .font(.title3) //TODO: #font
            .shadow(color: Shadow.color, radius: Shadow.radius)
    }
}
