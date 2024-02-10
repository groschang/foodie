//
//  CategoryListViewModel+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 17/05/2023.
//

import SwiftUI

struct CategoryListViewStyle: ViewModifier {

    private struct Colors {
        static let background = Color(light: Color.white,
                                      dark: Color.gray)
    }

    private struct Shadow {
        static let radius = 8.0
        static let color = Color.shadow
    }

    private struct Layouts {
        static let width = Double.infinity
        static let height = 90.0
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


fileprivate struct CategoryListViewTextStyle: ViewModifier {

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
            .modifier(CategoryListViewTextStyle())
    }
}

struct CategoryViewDescriptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .subtitle3()
            .modifier(CategoryListViewTextStyle())
    }
}


struct CategoryListViewPhotoStyle: ViewModifier {

    var width: CGFloat = 160
    var height: CGFloat = 160
    let imageUrl: URL?

    func body(content: Content) -> some View {
        content
            .modifier(ListPhotoStyle(width: width, height: height))
    }
}
