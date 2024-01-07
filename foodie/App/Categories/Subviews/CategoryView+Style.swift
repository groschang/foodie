//
//  CategoryView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 17/05/2023.
//

import SwiftUI

struct CategoryViewStyle: ViewModifier {

    private struct Colors {
        static let background = Color(light: Color.white,
                                      dark: Color.gray)
    }

    private struct Shadow {
        static let radius = 10.0
        static let color = Color.gray.heavierOpacity()
    }

    private struct Layouts {
        static let width = CGFloat.infinity
        static let height = 50.0
        static let radius = 8.0
    }

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: Layouts.width, minHeight: Layouts.height)
            .background(Colors.background)
            .cornerRadius(Layouts.radius)
            .shadow(color: Shadow.color, radius: Shadow.radius)
    }
}


fileprivate struct CategoryViewTextStyle: ViewModifier {

    private struct Colors {
        static let foreground = AppStyle.black
    }

    private struct Shadow {
        static let radius = 1.0
        static let color = Color.white.heavierOpacity()
    }

    func body(content: Content) -> some View {
        content
            .foregroundStyle(AppStyle.foreground)
            .shadow(color: Shadow.color, radius: Shadow.radius)
    }
}

struct CategoryViewNameStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .title()
            .modifier(CategoryViewTextStyle())
    }
}

struct CategoryViewDescriptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .subtitle3()
            .modifier(CategoryViewTextStyle())
    }
}


struct CategoryViewPhotoStyle: ViewModifier {

    var width: CGFloat = 160
    var height: CGFloat = 160
    let imageUrl: URL?

    func body(content: Content) -> some View {
        content
            .modifier(ListPhotoStyle(width: width, height: height))
//            .modifier(BlurredBackground(imageUrl: imageUrl))
    }
}
