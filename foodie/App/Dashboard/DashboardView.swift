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

    @State private var showSearch = false

    @FocusState var isFocused

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
            if !showSearch {
                mainContent
            } else {
                DashboardSearchView(namespace: namespace, show: $showSearch)
            }
        }
        .background {
            AppStyle.main
                .ignoresSafeArea()
        }
    }

    @ViewBuilder
    private var mainContent: some View {

        ZStack {
            listContent

            headerContent
                .placeAtTheTop()
        }
    }


    private var headerContent: some View {

        VStack(spacing: 20) {

            DashboardHeaderView {
                router.navigate(to: .menu)
            }

            DashboardTextfiledView(isFocused: $isFocused)
                .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .matchedGeometryEffect(id: DashboardSearchView.ElementID.textfield,
                                       in: namespace)
                .disabled(true)
                .onTapGesture {
                    withAnimation(AppStyle.Animations.transition) {
                        showSearch.toggle()
                    }
                }
        }
        .padding()
        .padding(.bottom, AppStyle.cornerRadius)
        .foregroundStyle(AppStyle.light)
        .background {
            AppStyle.main
                .matchedGeometryEffect(id: DashboardSearchView.ElementID.background,
                                       in: namespace)
                .ignoresSafeArea(edges: .top)
                .padding(.bottom, AppStyle.cornerRadius)
                .onTapGesture(perform: hideKeyboard)
        }
        .overlay {
            AppStyle.main
                .matchedGeometryEffect(id: DashboardSearchView.ElementID.chin,
                                       in: namespace)
                .frame(height: AppStyle.cornerRadius)
                .defaultCornerRadius(corners: .bottom)
                .defaultShadow()
                .mask(Rectangle().padding(.bottom, -AppStyle.cornerRadius))
                .placeAtTheBottom()
        }

    }

    private var listContent: some View {

        ScrollView {

            Color.clear
                .frame(height: 170)

            DashboardPromoView(viewModel: viewModel.promoViewModel) { }
                .maxWidth()
                .frame(maxHeight: 200)
                .modifier(ParallaxMotionModifier(manager: manager, magnitude: 10))
                .modifier(ParallaxShadowModifier(manager: manager, magnitude: 10))
                .padding(.vertical, 12)
            //  .modifier(SwipeModifier(manager: manager)) //TODO: optimize

            DashboardCategoriesView(viewModel: viewModel.categoriesViewModel) {

            }

            Spacer()
        }
        .background { StaticGradient() }
        .background { Color.white.ignoresSafeArea(edges: .bottom) }
//        .background {
//            Color.blue /*background*/
//                .ignoresSafeArea(edges: .bottom)
//        }

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

