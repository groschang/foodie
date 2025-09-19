//
//  AppStartupViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 7/9/25.
//  Copyright (C) 2025 Konrad Groschang - All Rights Reserved
//

import Foundation
import Combine

@MainActor
final class AppStartupViewModel: ObservableObject {

    @Published var dashboardViewModel: DashboardViewModel?
    @Published var viewFactory: AsyncViewFactory?
    @Published var router: Router? {
        didSet {
            observe(router, storeIn: &cancellables)
        }
    }
    @Published var notificationService: NotificationService? {
        didSet {
            observe(notificationService, storeIn: &cancellables)
        }
    }

#if MOCK
    private let container = MockedDependencyContainer.shared
#else
    private let container = DependencyContainer.shared
#endif

    private var cancellables: Set<AnyCancellable> = []

    init() {
        Task {
            await initialize()
        }
    }

    private func initialize() async {
        await container.assemble()

        Log.printDBPath()

        router = await container.router

        let service = await container.mealsService
        dashboardViewModel = DashboardViewModel(service: service)
        viewFactory = AsyncViewFactory(service: service)

        notificationService = await container.notificationService
    }
}

