//
//  DashboardTextfiledView.swift
//  foodie
//
//  Created by Konrad Groschang on 07/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct DashboardTextfiledView: View {

    enum ShapeType {
        case normal
        case reversed
    }

    @State private(set) var search: String = ""

    var isFocused: FocusState<Bool>.Binding

    private var type: ShapeType

    init(isFocused: FocusState<Bool>.Binding, type: ShapeType = .normal) {
        self.isFocused = isFocused
        self.type = type
    }

    var body: some View {
        HStack {

            Image(systemName: "sparkle.magnifyingglass")
                .foregroundStyle(isFocused.wrappedValue ? AppStyle.blue : AppStyle.lightGray)
                .scaleEffect(isFocused.wrappedValue ? 1.4 : 1.0 )
                .animation(.easeInOut, value: isFocused.wrappedValue)

            TextField("",
                      text: $search,
                      prompt: Text("Search for recipe").foregroundColor(Color.lightGray)
            )
            .foregroundStyle(Color.gray)
            .accentColor(Color.blue)
            .focused(isFocused)
            .disableAutocorrection(true)
            // .onSubmit {
            //   validate(name: username)
            // }

        }
        .padding()
        .background(.white)
        .decorateLeaf(type)
    }
}

private extension View {

    @ViewBuilder
    func decorateLeaf(_ type: DashboardTextfiledView.ShapeType) -> some View {
        switch type {
        case .normal:
            self.leafRounded()
        case .reversed:
            self.reversedLeafRounded()
        }
    }
}

#Preview {
    DashboardTextfiledView(isFocused: FocusState<Bool>().projectedValue)
}
