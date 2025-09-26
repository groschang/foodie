//
//  TextView.swift
//  foodie
//
//  Created by Konrad Groschang on 16/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct TextView<Style: ViewModifier>: View {

    let text: String

    let style: Style

    init(_ text: String, style: Style = NoStyle()) {
        self.text = text
        self.style = style
    }

    var body: some View {
        Text(text)
            .modifier(style)
    }
}

// MARK: - Preview

#Preview {
    TitleView("TitleView")
        .previewAsComponent()
}
