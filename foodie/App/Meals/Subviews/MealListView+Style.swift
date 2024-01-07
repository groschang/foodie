//
//  MealListView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import SwiftUI

struct MealListStyle: ViewModifier {

    private struct Colors {
        static let background = Color(light: Color.white,
                                      dark: Color.gray)
    }

    private struct Shadow {
        static let radius = 10.0
        static let color = Color.shadow
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
        static let foreground = AppStyle.black
    }

    private struct Shadow {
        static let radius = 1.0
        static let color = Color.darkWhite
    }

    func body(content: Content) -> some View {
        content
            .foregroundStyle(AppStyle.foreground)
            .multilineTextAlignment(.leading)
            .lineLimit(4)
            .minimumScaleFactor(0.8)
        //            .font(.title3) //TODO: #font
            .font( //TODO: #font
                .custom(
                    "AmericanTypewriter",
                    fixedSize: 25)
                .weight(.semibold)

            )
            .shadow(color: Shadow.color, radius: Shadow.radius)
    }
}
