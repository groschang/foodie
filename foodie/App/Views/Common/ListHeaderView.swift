//
//  ListHeaderView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/04/2023.
//

import SwiftUI

struct ListHeaderView: View {

    let title: String
    let action: VoidAction?

    init(title: String, action: VoidAction?) {
        self.title = title
        self.action = action
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.footnote)

            Spacer()

            Button(
                action: { action?() },
                label: {
                    Text("Filter")
                        .font(.footnote)
                        .tint(.white)
                }
            )
        }
    }
}

// MARK: Previews

struct ListHeaderView_Previews: PreviewProvider {

    static var previews: some View {
        ListHeaderView(title: "Title", action: { } )
            .previewAsComponent()
    }
}
