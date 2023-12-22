//
//  DebugSection.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//

import SwiftUI

struct DebugSection<Content: View>: View {

    private let title: String

    private let content: () -> Content

    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        Section(
            content: content,
            header: {
                Text(title)
                    .bold()
                    .foregroundStyle(.black)
                    .subtitle()
                    .listRowInsets(.zero)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(Color(r: 169, g: 252, b: 210))
                    .leafShaped()
                    .padding(.bottom)
            }
        )
    }
}
