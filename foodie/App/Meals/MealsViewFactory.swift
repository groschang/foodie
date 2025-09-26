//
//  MealsViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

class MealsViewFactory: MealsAsyncViewFactory { }


@MainActor
class MealsClosureViewFactory: ViewBuilderProtocol {

    private let service: MealsClosureServiceType

    init(service: MealsClosureServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView(item category: any IdentifiableObject) -> some View {
        let viewModel = MealsViewModel(service: service, category: category)
        MealsView(viewModel: viewModel)
    }

    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}


@MainActor
class MealsAsyncViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncServiceType

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView(item category: any IdentifiableObject) -> some View {
        let viewModel = MealsAsyncViewModel(service: service, category: category)
        MealsView(viewModel: viewModel)
    }

    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}


@MainActor
class MealsAsyncStreamViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncStreamServiceType

    init(service: MealsAsyncStreamServiceType) {
        self.service = service
    }

    @ViewBuilder
    func makeView(item category: any IdentifiableObject) -> some View {
        let viewModel = MealsAsyncStreamViewModel(service: service, category: category)
        MealsView(viewModel: viewModel)
    }

    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}

// MARK: - Mock

#if DEBUG
extension MealsViewFactory {
    @MainActor static let mock = MealsViewFactory(service: MealsAsyncServicePreview())
}
#endif
