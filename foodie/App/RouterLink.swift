//
//  RouterLink.swift
//  foodie
//
//  Created by Konrad Groschang on 04/10/2023.
//

import SwiftUI

struct RouterLink<Label: View>: View {

    @EnvironmentObject var router: Router

    let value: Router.Destination
    private var label: () -> Label

    init(to value: Router.Destination,
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
