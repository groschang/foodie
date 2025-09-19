//
//  ListHeader.swift
//  foodie
//
//  Created by Konrad Groschang on 29/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ListHeader: View {

    let title: String

    @Binding var listType: ListType

    var dismissAction: VoidAction

    var body: some View {
        HStack(spacing: .zero) {

            BackButton { dismissAction() }
                .tint(.white)

            Spacer()
            Text(title)
                .font(.title)
                .foregroundStyle(AppStyle.white)
            Spacer()

            ListTypeButton(
                type: listType,
                action: {
                    withAnimation {
                        listType = listType.next()
                    }
                }
            )
            .tint(.white)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(Color.accent)
    }

}


// MARK: Preview

#Preview {

    struct Preview: View {
        @State private var listType: ListType = .grid

        var body: some View {
            ListHeader(title: Category.stub.name,
                       listType: $listType,
                       dismissAction: { })
        }
    }

    return Preview()
        .previewAsComponent()
}
