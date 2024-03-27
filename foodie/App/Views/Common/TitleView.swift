//
//  TitleView.swift
//  foodie
//
//  Created by Konrad Groschang on 08/02/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct TitleView<Style: ViewModifier>: View {

    let title: String

    let style: Style
    
    init(_ title: String, style: Style = NoStyle()) {
        self.title = title
        self.style = style
    }
    
    var body: some View {
        HStack {
            Text(title)
                .modifier(style)
            
            Spacer()
        }
    }
}

// MARK: Preview

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView("TitleView")
            .previewAsComponent()
    }
}



