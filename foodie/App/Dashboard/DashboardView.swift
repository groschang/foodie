//
//  Dashboard.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//

import SwiftUI

struct DashboardView<Model>: View where Model: DashboardViewModelType {

    @EnvironmentObject var router: Router

    @Environment(\.colorScheme) var systemColorScheme

    @StateObject private var viewModel: Model

    @StateObject private var manager = ParallaxManager()

    @AppStorage(UserDefaultsKeys.appTheme) var appTheme: AppTheme = .system



    init(viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
        //            .navigationTitle("Welcome back")
            .preferredColorScheme(appTheme.colorScheme(system: systemColorScheme))
            .accentColor(Color.accent)
            .task { await viewModel.initialize() }
            .onAppear { manager.start() }
            .onDisappear { manager.stop() }
    }

    private var content: some View {
        VStack {
            DashboardHeaderView {
                router.navigate(to: .menu)
            }
            .toolbarBackground(AppStyle.light, for: .navigationBar)

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
        .background {
            Color.background
                .ignoresSafeArea()
        }

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
