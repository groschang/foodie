//
//  ListStyle.swift
//  foodie
//
//  Created by Konrad Groschang on 17/05/2023.
//

import SwiftUI

struct ListStyle: ViewModifier {

    private struct Colors {
        static let accent = ColorStyle.accent.mediumOpacity()
        static let background = ColorStyle.background.lightMediumOpacity()
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
