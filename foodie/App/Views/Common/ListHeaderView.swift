//
//  ListHeaderView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/04/2023.
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
                .font(.footnote) // TODO: #font

            Spacer()

            ListTypeButton(
                type: listType,
                action: modeAction
            )
            .tint(Color.foreground)


            ListFilterButton(action: filterAction)
                .tint(Color.foreground)
        }
    }
}

// MARK: Previews

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView(title: "Title",
                       filterAction: { },
                       modeAction: { },
                       listType: .constant(.list))
        .previewAsComponent()
    }
}

