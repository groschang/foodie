//
//  CategoriesViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

class CategoriesViewFactory: CategoriesAsyncViewFactory { }


@MainActor
class CategoriesClosureViewFactory: ViewBuilderProtocol {

    private let service: MealsClosureServiceType

    init(service: MealsClosureServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView() -> some View {
        let viewModel = CategoriesViewModel(service: service)
        CategoriesView(viewModel: viewModel)
    }

    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}


@MainActor
class CategoriesAsyncViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncServiceType

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView() -> some View {
        let viewModel = CategoriesAsyncViewModel(service: service)
        CategoriesView(viewModel: viewModel)
    }

    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}


@MainActor
class CategoriesAsyncStreamViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncStreamServiceType

    init(service: MealsAsyncStreamServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView() -> some View {
        let viewModel = CategoriesAsyncStreamViewModel(service: service)
        CategoriesView(viewModel: viewModel)
    }

    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}

// MARK: - Mock

#if DEBUG
extension CategoriesViewFactory {
    @MainActor static let mock = CategoriesViewFactory(service: MealsAsyncServicePreview())
}
#endif
