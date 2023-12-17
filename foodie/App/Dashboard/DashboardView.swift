//
//  Dashboard.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//

import SwiftUI

struct DashboardView<Model>: View where Model: DashboardViewModelType {

    @EnvironmentObject var router: Router

    @StateObject private var viewModel: Model

    @StateObject private var manager = ParallaxManager()

    init(viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle("Welcome back")
            .task { await viewModel.load() }
            .onAppear { manager.start() }
            .onDisappear { manager.stop() }
            .accentColor(ColorStyle.accent)
    }

    private var content: some View {
        VStack {
            DashboardHeaderView { Log.debug("click") }
                .toolbarBackground(ColorStyle.appColor, for: .navigationBar)

            DashboardPromoView(viewModel: viewModel.promoViewModel) { }
                .maxWidth()
                .frame(maxHeight: 200)
                .modifier(ParallaxMotionModifier(manager: manager, magnitude: 10))
                .modifier(ParallaxShadowModifier(manager: manager, magnitude: 10))
                .padding(.vertical, 12)
//                .modifier(SwipeModifier(manager: manager)) //TODO: optimize

            DashboardCategoriesView(viewModel: viewModel.categoriesViewModel) {

            }

            Spacer()
        }
    }
}


// MARK: Preview

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModel.mock)
    }
}
