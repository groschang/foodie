//
//  CategoriesView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ListModifier: ViewModifier {

    @MainActor
    private struct Colors {
        static let background = Color.background
    }

    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
            .tint(Colors.background)
    }
}


struct ListRowModifier: ViewModifier {

    @MainActor
    private struct Colors {
        static let background = Color.background
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


struct CategoriesViewListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
    }
}
