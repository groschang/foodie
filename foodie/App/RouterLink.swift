//
//  RouterLink.swift
//  foodie
//
//  Created by Konrad Groschang on 04/10/2023.
//

import SwiftUI

typealias RouterLinkStyle = ButtonStyle

struct RouterLink<Label: View, Style: RouterLinkStyle>: View {

    @EnvironmentObject var router: Router

    let value: Route
    private var label: () -> Label
    private var style: Style

    init(to value: Route,
         style: Style = .plainLink,
         @ViewBuilder label: @escaping () -> Label) {
        self.value = value
        self.style = style
        self.label = label
    }

    var body: some View {
        Button(
            action: { router.navigate(to: value) },
            label: label
        )
        .buttonStyle(style)
    }
}




struct PlainRouterLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

extension RouterLinkStyle where Self == PlainRouterLinkStyle {
    static var plainLink: Self { .init() }
}
