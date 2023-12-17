//
//  DashboardViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//

import SwiftUI

class DashboardViewFactory {

    private let service: MealsAsyncServiceType

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView() -> some View {
        let viewModel = DashboardViewModel(service: service)
        DashboardView(viewModel: viewModel)
    }
}

// MARK: Mock

extension DashboardViewFactory {
    static let mock = DashboardViewFactory(service: MealsAsyncService())
}
