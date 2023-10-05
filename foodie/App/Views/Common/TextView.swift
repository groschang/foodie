//
//  TextView.swift
//  foodie
//
//  Created by Konrad Groschang on 16/07/2023.
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

// MARK: Preview

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView("TitleView")
            .previewAsComponent()
    }
}
