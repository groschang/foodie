//
//  DashboardHeaderView.swift
//  foodie
//
//  Created by Konrad Groschang on 08/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct DashboardHeaderView: View {

    var namespace: Namespace.ID

    @Binding var presentingSearch: Bool

    @FocusState private var isFocused

    var onMenuPressed: VoidAction?

    var body: some View {

        NavigationCustomHeader {

            DashboardHeaderDetailView {
                onMenuPressed?()
            }

            DashboardTextfiledView(isFocused: $isFocused)
                .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .matchedGeometryEffect(id: DashboardSearchView.ElementID.textfield,
                                       in: namespace)
                .onTapGesture {
                    withAnimation(AppStyle.Animations.transition) {
                        presentingSearch.toggle()
                    }
                }
        }
        .background {
            NavigationCustomBackground(color: AppStyle.main)
                .matchedGeometryEffect(id: DashboardSearchView.ElementID.background,
                                       in: namespace)
                .onTapGesture(perform: hideKeyboard)
        }
    }
}


#Preview {
    @Namespace var namespace

    return DashboardHeaderView(namespace: namespace,
                               presentingSearch: .constant(false))
}
