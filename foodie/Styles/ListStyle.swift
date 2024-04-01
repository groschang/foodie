//
//  ListStyle.swift
//  foodie
//
//  Created by Konrad Groschang on 17/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ListStyle: ViewModifier { //TODO: CHECK

    private struct Colors {
        static let accent = Color.accent.mediumOpacity()
        static let background = Color.background.lightOpacity()
    }

    private struct Paddings {
        static let horizontal = 20.0
    }

    private struct Inserts { //TODO: is it needed?
        static let rowInserts = EdgeInsets(
            top: 0,
            leading: 20,
            bottom: 0,
            trailing: 30
        )
    }

    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(
                Colors.background
                    .padding(.horizontal, Paddings.horizontal)
            )
            .accentColor(Colors.accent)
    }
}

extension ListStyle {

    static let textInserts = EdgeInsets(vertical: 10, horizontal: 30)
}

extension View {
    func zeroListRowInsert() -> some View {
        listRowInsets(EdgeInsets())
    }
}
