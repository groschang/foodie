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
@MainActor
struct foodieApp: App {

    @Environment(\.scenePhase) var scenePhase
    @StateObject private var appStartup = AppStartupViewModel()

    var body: some Scene {
        WindowGroup {
            if let dashboardViewModel = appStartup.dashboardViewModel,
               let viewFactory = appStartup.viewFactory,
               let router = appStartup.router,
               let notificationService = appStartup.notificationService {
                content(
                    dashboardViewModel: dashboardViewModel,
                    viewFactory: viewFactory,
                    router: router,
                    notificationService: notificationService
                )
            } else {
                ProgressView("Loading...")
            }
        }
    }

    @ViewBuilder
    private func content(
        dashboardViewModel: DashboardViewModel,
        viewFactory: StreamViewFactory,
        @ObservedObject router: Router,
        @ObservedObject notificationService: NotificationService
    ) -> some View {
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
        .onChange(of: scenePhase) { _, newPhase in
            Log.debug("Scene phase: \(newPhase)")
            if newPhase == .active {
                applicationIsActive()
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
