//
//  ExtendedTitleView.swift
//  foodie
//
//  Created by Konrad Groschang on 16/07/2023.
//

import SwiftUI

struct ExtendedTitleView<TitleStyle, SubtitleStyle>: View where TitleStyle: ViewModifier, SubtitleStyle: ViewModifier {

    let title: String

    let titleStyle: TitleStyle

    let subtitle: String

    let subtitleStyle: SubtitleStyle


    init(_ title: String, style: TitleStyle = TextStyle.title,
         subtitle: String, subtitleStyle: SubtitleStyle = TextStyle.subtitle) {
        self.title = title
        self.titleStyle = style
        self.subtitle = subtitle
        self.subtitleStyle = subtitleStyle
    }

    var body: some View {
        HStack {
            TitleView(title, style: titleStyle)

            Text(subtitle)
                .modifier(subtitleStyle)
        }
    }
}

// MARK: Preview

struct ExtendedTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedTitleView("TitleView", style: TextStyle.title,
                          subtitle: "Subtitle", subtitleStyle: TextStyle.subtitle)
        .previewAsComponent()
    }
}



