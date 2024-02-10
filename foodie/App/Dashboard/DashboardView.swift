//
//  Dashboard.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//

import SwiftUI

struct DashboardView<Model>: View where Model: DashboardViewModelType {

    @AppStorage(UserDefaultsKeys.appTheme) var appTheme: AppTheme = .system

    @EnvironmentObject var router: Router

    @StateObject private var viewModel: Model

    @StateObject private var manager = ParallaxManager()

    @Namespace private var namespace

    @State private var presentingSearch = false


    init(viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .toolbarBackground(AppStyle.toolbar, for: .navigationBar)
            .preferredColorScheme(appTheme.colorScheme)
            .accentColor(Color.accent)
            .task { await viewModel.initialize() }
            .onAppear { manager.start() }
            .onDisappear { manager.stop() }
    }

    @ViewBuilder
    private var content: some View {
        ZStack {
            if presentingSearch {
                searchView
            } else {
                mainContent
            }
        }
        .background {
            AppStyle.main.ignoresSafeArea()
        }
    }

    private var searchView: some View {
        DashboardSearchView(namespace: namespace, isPresenting: $presentingSearch)
    }

    @ViewBuilder
    private var mainContent: some View {
        ZStack {
            container
            header
                .placeAtTheTop()
        }
    }

    private var header: some View {
        DashboardHeaderView(
            namespace: namespace,
            presentingSearch: $presentingSearch,
            onMenuPressed: { router.navigate(to: .menu) }
        )
    }

    private var container: some View {

        ScrollView {
            VStack {

                Color.clear
                    .frame(height: 180)

                DashboardPromoView(viewModel: viewModel.promoViewModel) { }
                    .maxWidth()
                    .frame(maxHeight: 240)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: 10))
                    .modifier(ParallaxShadowModifier(manager: manager, magnitude: 10))
                    .padding(.vertical, 12)
                    .padding(.bottom, 12)
                //  .modifier(SwipeModifier(manager: manager)) //TODO: optimize

                DashboardCategoriesView(viewModel: viewModel.categoriesViewModel) {
                    router.navigate(to: .categories) 
                }
                .padding(.bottom, 32)

                DashboardMealsView(viewModel: viewModel.mealsViewModel)

                Spacer()
            }
        }
        .background { StaticGradient().rotationEffect(Angle(degrees: 90)) }
        .background { Color.white.ignoresSafeArea(edges: .bottom) }
    }

}


// MARK: Preview

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DashboardView(viewModel: DashboardViewModel.mock)
        }
    }
}

