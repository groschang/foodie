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

    private let dashboardViewModel: DashboardViewModel

    private let viewFactory: ViewFactory
    @ObservedObject private var router: Router

    init() {
        container.assemble()

        DatabaseLogger.printPath()

        dashboardViewModel = DashboardViewModel(service: container.serviceV)

        router = Router()
        viewFactory = ViewFactory(service: container.service,
                                  asyncService: container.serviceV)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                DashboardView(viewModel: dashboardViewModel)
                    .navigationDestination(for: Router.Destination.self) { destination in
                        viewFactory.makeView(type: .init(destination))
                    }
            }
            .environmentObject(router)
        }
    }
}
