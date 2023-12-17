//
//  RouterLink.swift
//  foodie
//
//  Created by Konrad Groschang on 04/10/2023.
//

import SwiftUI

struct RouterLink<Label: View>: View {

    @EnvironmentObject var router: Router

    let value: Route
    private var label: () -> Label

    init(to value: Route,
         @ViewBuilder label: @escaping () -> Label) {
        self.value = value
        self.label = label
    }

    var body: some View {
        Button(
            action: { router.navigate(to: value) },
            label: label
        )
    }
}
