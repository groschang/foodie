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

    private let notificationPublisher = NotificationCenter.default.publisher(for: Notification.Name.foodie)
    @State private var showAlert : Bool = false
    @State private var notification: UNNotificationContent = .init()

    init() {
        container.assemble()

        Log.printDBPath()

        Task {
           try? await NotificationManager.shared.requestPermission()
        }

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
        .onReceive(notificationPublisher) { data in
            if let content = (data.object as? UNNotificationContent) {
                self.notification = content
                showAlert = true
            }
        }
        .alert(isPresented : $showAlert){
            Alert(title: Text(notification.title),
                  message: Text(notification.body),
                  dismissButton: .default(Text("OK")))
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
