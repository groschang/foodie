//
//  CategoriesView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import SwiftUI

struct ListModifier: ViewModifier {

    private struct Colors {
        static let background = ColorStyle.blue.heavyOpacity()
    }

    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
            .tint(Colors.background)
    }
}

struct ListRowModifier: ViewModifier {

    private struct Colors {
        static let background = ColorStyle.blue.heavyOpacity()
    }

    private struct Paddings {
        static let vertical = 8.0
        static let horizontal = 16.0
    }

    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(Colors.background)
            .listRowInsets(.zero)
            .padding(.vertical, Paddings.vertical)
            .padding(.horizontal, Paddings.horizontal)
    }
}
