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

    #if MOCK
    private let container = MockedDependencyContainer.shared
    #else
    private let container = DependencyContainer.shared
    #endif

    private let dashboardViewModel: DashboardViewModel
    
    private let viewFactory: StreamViewFactory
    @ObservedObject private var router: Router
    
    init() {
        container.assemble()
        
        DatabaseLogger.printPath()
        
        dashboardViewModel = DashboardViewModel(service: container.asyncService)
        
        router = Router()
        viewFactory = StreamViewFactory(service: container.asyncStreamService)
    }
    
    var body: some Scene {
        WindowGroup {
            content
        }
    }
    
    fileprivate var content: some View {
        NavigationStack(path: $router.navigationPath) {
            DashboardView(viewModel: dashboardViewModel)
                .navigationDestination(for: Route.self) { route in
                    viewFactory.makeView(type: route)
                }
                .onOpenURL { url in
                    Log.log(url, onLevel: .verbose)
                    if let route = Route(url: url) {
                        router.navigate(to: route)
                    }
                }
        }
        .environmentObject(router)
    }
}


// MARK: Previews

struct foodieApp_Previews: PreviewProvider {
    static var previews: some View {
        foodieApp().content
    }
}
