//
//  ListTypeButton.swift
//  foodie
//
//  Created by Konrad Groschang on 23/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ListTypeButton: View {

    let type: ListType

    let action: VoidAction

    var body: some View {
        Button(
            action: { action() },
            label: {
                type.image
                    .animation(.spring())
            }
        )
    }
}
