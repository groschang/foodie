//
//  MultilineTextView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MultilineTextView<Style: ViewModifier>: View {

    let text: String

    let style: Style

    init(_ text: String, style: Style = NoStyle()) {
        self.text = text
        self.style = style
    }

    var body: some View {
        HStack {
            Text(text)
                .multilineTextAlignment(.leading)
                .modifier(style)

            Spacer()
        }
    }
}

// MARK: - Preview

#Preview {
    MultilineTextView("TitleView")
        .previewAsComponent()
}
