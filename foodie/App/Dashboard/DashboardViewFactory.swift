//
//  DashboardViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

class DashboardViewFactory {

    private let service: MealsAsyncServiceType

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @ViewBuilder @MainActor 
    func makeView() -> some View {
        let viewModel = DashboardViewModel(service: service)
        DashboardView(viewModel: viewModel)
    }
}

// MARK: Mock

extension DashboardViewFactory {
    @MainActor static let mock = DashboardViewFactory(service: MealsAsyncService())
}
