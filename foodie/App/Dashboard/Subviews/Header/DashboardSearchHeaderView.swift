//
//  DashboardSearchHeaderView.swift
//  foodie
//
//  Created by Konrad Groschang on 08/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct DashboardSearchHeaderView: View {

    var namespace: Namespace.ID

    @Binding var presentingSearch: Bool

    @FocusState private var isFocused


    var body: some View {

        NavigationCustomHeader {

            DashboardTextfiledView(isFocused: $isFocused, type: .reversed)
                .matchedGeometryEffect(id: DashboardSearchView.ElementID.textfield,
                                       in: namespace)

        }
        .background {
            NavigationCustomBackground(color: Color.red)
                .matchedGeometryEffect(id: DashboardSearchView.ElementID.background,
                                       in: namespace)
                .onTapGesture {
                    withAnimation(AppStyle.Animations.transition) {
                        presentingSearch.toggle()
                    }
                }
//                .onTapGesture(perform: hideKeyboard)
        }
    }
}


#Preview {
    @Namespace var namespace

    return DashboardSearchHeaderView(namespace: namespace,
                                     presentingSearch: .constant(false))
}
