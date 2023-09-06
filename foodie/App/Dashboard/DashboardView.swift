//
//  Dashboard.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//

import SwiftUI

protocol RouterProtocol: Hashable {
    associatedtype V
    func makeView() -> V
}

struct DashboardView<DI, ViewModel, ViewFactory>: View

where DI: DependencyContainerType,
      ViewModel: DashboardViewModelType,
      ViewFactory: DashboardViewFactoryType {

    private let container: DI

    @StateObject private var viewModel: ViewModel

    private var viewFactory: ViewFactory
    //    @StateObject var router: Router //TODO: CHANGEEEEE

    init(container: DI, viewModel: ViewModel, viewFactory: ViewFactory) {
        self.container = container
        self.viewFactory = viewFactory
        _viewModel = StateObject(wrappedValue: viewModel)
        //        _router = StateObject(wrappedValue: container.router)
    }

    var body: some View {
        NavigationStack { //(path: $router.path) {
            content
                .navigationTitle("Foodie")
                .navigationDestination(for: CategoriesRouter.self) { router in
                    router.makeView()
                }
                .navigationDestination(for: MealsRouter.self) { router in
                    router.makeView()
                }
                .navigationDestination(for: MealRouter.self) { router in
                    router.makeView()
                }
                .task { await viewModel.load() }
        }
        .accentColor(ColorStyle.accent)
    }

    private let manager = ParallaxManager()

    private var content: some View {
        VStack {
            DashboardHeaderView { Log.debug("click") }
                .toolbarBackground(ColorStyle.appColor, for: .navigationBar)

            DashboardPromoView(viewModel: viewModel.promoViewModel) { }
                .maxWidth()
                .frame(height: 200)
                .frame(maxHeight: 200)
                .modifier(ParallaxMotionModifier(manager: manager, magnitude: 10))
                .modifier(ParallaxShadowModifier(manager: manager, magnitude: 10))
                .padding(.vertical, 12)
                .modifier(SwipeModifier(manager: manager))

            DashboardCategoriesView(viewModel: viewModel.categoriesViewModel) {

            }

            Spacer()
        }
        .background(.gray)
    }
}


// MARK: Preview

struct Dashboard_Previews: PreviewProvider {

    static let container: some DependencyContainerType = {
        let container = MockDependencyContainer()
        container.assemble()
        return container
    }()

    static var previews: some View {
        DashboardView(container: container,
                      viewModel: DashboardViewModel.mock,
                      viewFactory: DashboardViewFactory.mock)
    }
}
