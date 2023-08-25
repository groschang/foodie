//
//  foodieApp.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import SwiftUI
@_exported import Logger

public typealias Log = Logger

@main
struct foodieApp: App {

    private let container = MockDependencyContainer()

    private let viewModel: DashboardViewModel
    private let viewFactory: DashboardViewFactory

    init() {
        container.assemble()

        DatabaseLogger.printPath()

        viewModel = DashboardViewModel(service: container.serviceV)
        viewFactory = DashboardViewFactory(service: container.service)
    }
    
    var body: some Scene {
        WindowGroup {
            DashboardView(container: container,
                          viewModel: viewModel,
                          viewFactory: viewFactory)

            //            CategoriesView(
            //                viewModel: container.categoriesViewModel,
            //                viewFactory: container.categoriesViewFactory
            //            )
        }
    }
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()
}
