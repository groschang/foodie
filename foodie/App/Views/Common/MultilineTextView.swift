//
//  MultilineTextView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/05/2023.
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

// MARK: Preview

struct MultilineTextView_Previews: PreviewProvider {

    static var previews: some View {
        MultilineTextView("TitleView")
            .previewAsComponent()
    }
}
