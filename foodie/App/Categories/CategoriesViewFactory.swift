//
//  CategoriesViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import SwiftUI

class CategoriesViewFactory: ViewBuilderProtocol {

    private let service: MealsServiceType
    private let asyncService: MealsServiceAsyncType

    init(service: MealsServiceType,
         asyncService: MealsServiceAsyncType) {
        self.service = service
        self.asyncService = asyncService
    }

    @MainActor @ViewBuilder
    func makeView() -> some View {
        let viewModel = CategoriesViewModel(service: asyncService)
        CategoriesView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}

// MARK: Mock

extension CategoriesViewFactory {
    static let mock = CategoriesViewFactory(service: MealsServiceMock(), asyncService: MealsServiceAsyncMock())
}
