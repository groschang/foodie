//
//  CategoryPostItem+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 9/24/25.
//

import SwiftUI

struct CategoryPostItemStyle: ViewModifier {

    private struct Colors {
        static let background = Color(light: Color.white,
                                      dark: Color.gray)
    }

    @MainActor
    private struct Shadow {
        static let radius = 4.0
        static let color = Color.shadow
    }

    private struct Layouts {
        static let width = Double.infinity
        static let height = 90.0
        static let radius = 16.0
    }

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: Layouts.width, minHeight: Layouts.height)
            .background(Colors.background)
            .cornerRadius(Layouts.radius)
            .shadow(color: Shadow.color, radius: Shadow.radius)
    }
}


struct CategoryPostItemNameStyle: ViewModifier {

    private struct Colors {
        static let foreground = AppStyle.foreground
    }

    @MainActor
    private struct Shadow {
        static let radius = 1.0
        static let color = AppStyle.background.heavierOpacity().color
    }

    func body(content: Content) -> some View {
        content
            .foregroundStyle(Colors.foreground)
            .shadow(color: Shadow.color, radius: Shadow.radius)
            .title3()
    }
}


struct CategoryPostItemDescriptionStyle: ViewModifier {

    private struct Colors {
        static let foreground = AppStyle.foreground
    }

    @MainActor
    private struct Shadow {
        static let radius = 1.0
        static let color = AppStyle.background.heavierOpacity().color
    }

    func body(content: Content) -> some View {
        content
            .foregroundStyle(Colors.foreground)
            .shadow(color: Shadow.color, radius: Shadow.radius)
            .subtitle3()
    }
}


struct CategoryPostViewPhotoStyle: ViewModifier {

    var width: CGFloat = 160
    var height: CGFloat = 160
    let imageUrl: URL?

    func body(content: Content) -> some View {
        content
            .modifier(ListPhotoStyle(width: width, height: height))
    }
}
