//
//  CategoriesViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import SwiftUI

class CategoriesViewFactory: CategoriesClosureViewFactory { }


class CategoriesClosureViewFactory: ViewBuilderProtocol {

    private let service: MealsClosureServiceType

    init(service: MealsClosureServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView() -> some View {
        let viewModel = CategoriesViewModel(service: service)
        CategoriesView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}


class CategoriesAsyncViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncServiceType

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView() -> some View {
        let viewModel = CategoriesAsyncViewModel(service: service)
        CategoriesView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}


class CategoriesAsyncStreamViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncStreamServiceType

    init(service: MealsAsyncStreamServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView() -> some View {
        let viewModel = CategoriesAsyncStreamViewModel(service: service)
        CategoriesView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}

// MARK: Mock

extension CategoriesViewFactory {
    static let mock = CategoriesViewFactory(service: MealsServicePreview())
}
