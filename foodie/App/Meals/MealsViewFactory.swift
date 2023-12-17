//
//  MealsViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import SwiftUI

class MealsViewFactory: ViewBuilderProtocol {

    private let service: MealsServiceType
    private let asyncService: MealsServiceAsyncType

    init(service: MealsServiceType,
         asyncService: MealsServiceAsyncType) {
        self.service = service
        self.asyncService = asyncService
    }

    @MainActor @ViewBuilder
    func makeView(item category: any IdentifiableObject) -> some View {
        let viewModel = MealsAsyncViewModel(service: asyncService, category: category)
        MealsView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}

// MARK: Mock

extension MealsViewFactory {
    static let mock = MealsViewFactory(service: MealsServiceMock(), asyncService: MealsServiceAsyncMock())
}
