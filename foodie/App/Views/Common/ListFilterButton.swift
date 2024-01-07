//
//  ListFilterButton.swift
//  foodie
//
//  Created by Konrad Groschang on 23/12/2023.
//

import SwiftUI

struct ListFilterButton: View {

    let action: VoidAction

    var body: some View {
        Button(
            action: { action() },
            label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
            }
        )
    }
}
