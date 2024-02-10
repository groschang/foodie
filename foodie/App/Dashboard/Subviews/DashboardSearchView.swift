//
//  DashboardSearchView.swift
//  foodie
//
//  Created by Konrad Groschang on 07/01/2024.
//

import SwiftUI

struct DashboardSearchView: View {

    enum ElementID {
        static let textfield = "Textfield"
        static let background = "Background"
    }

    var namespace: Namespace.ID

    @Binding var isPresenting: Bool

    @FocusState var isFocused: Bool


    var body: some View {
        VStack {
            ZStack {
                content
                header
                    .placeAtTheTop()
            }
        }
        .onAppear { isFocused = true }
        .onDisappear { isFocused = false }
    }

    private var header: some View {
        DashboardSearchHeaderView(
            namespace: namespace,
            presentingSearch: $isPresenting
        )
    }

    private var content: some View {
        List {
            ForEach(1...20, id: \.self) { item in
                Text("Item: \(item)")
            }
        }
        .offset(y: 100)
        .redacted(reason: .placeholder)
        .onTapGesture { //TODO: remove
            withAnimation(AppStyle.Animations.transition) {
                isPresenting.toggle()
            }
        }
    }
}


#Preview {

    @Namespace var namespace
    @State var show: Bool = true

    return DashboardSearchView(
        namespace: namespace,
        isPresenting: $show
    )

}
