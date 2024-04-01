//
//  foodieApp.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI
@_exported import Logger

public typealias Log = Logger

@main
struct foodieApp: App {

    @Environment(\.scenePhase) var scenePhase

#if MOCK
    private let container = MockedDependencyContainer.shared
#else
    private let container = DependencyContainer.shared
#endif

    private let dashboardViewModel: DashboardViewModel

    private let viewFactory: StreamViewFactory
    @ObservedObject private var router: Router

    @ObservedObject private var notificationService: NotificationService

    init() {
        container.assemble()

        Log.printDBPath()

        notificationService = NotificationService()

        let service = container.asyncService
        dashboardViewModel = DashboardViewModel(service: service)

        router = container.router
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
        .onAppear {
            notificationService.run()
        }
        .onChange(of: scenePhase) { newPhase in

            Log.debug("Scene phase: \(newPhase)")

            switch newPhase {

            case .background:
                break
            case .inactive:
                break
            case .active:
                applicationIsActive()
            @unknown default:
                break
            }
        }
        .popup(isPresented: $notificationService.showNotification,
               notification: notificationService.notification) { notification in
            NotificationView(notification: notification) {
                notificationService.hideNotification()
            }
        }
        .styleNavigationStack()
        .environmentObject(router)
    }

    private func applicationIsActive() {
        Task {
            await NotificationManager.shared.refreshStatus()
        }
    }
}



// MARK: Previews

struct foodieApp_Previews: PreviewProvider {
    static var previews: some View {
        foodieApp().content
    }
}
