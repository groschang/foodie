//
//  ListHeaderView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/04/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ListHeaderView: View {

    let title: String
    let filterAction: VoidAction
    let modeAction: VoidAction

    @Binding var listType: ListType

    init(
        title: String,
        filterAction: @escaping VoidAction,
        modeAction: @escaping VoidAction,
        listType: Binding<ListType>
    ) {
        self.title = title
        self.filterAction = filterAction
        self.modeAction = modeAction
        self._listType = listType
    }

    var body: some View {
        HStack {

            Text(title)
                .subtitle3()

            Spacer()

            ListTypeButton(
                type: listType,
                action: modeAction
            )

            ListFilterButton(action: filterAction)
        }
        .tint(AppStyle.gray)
    }
}


// MARK: Previews

#Preview {
    ListHeaderView(
        title: "Title",
        filterAction: { },
        modeAction: { },
        listType: .constant(.list)
    )
}

