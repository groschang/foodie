//
//  MealsViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

class MealsViewFactory: MealsClosureViewFactory { }


class MealsClosureViewFactory: ViewBuilderProtocol {

    private let service: MealsClosureServiceType

    init(service: MealsClosureServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView(item category: any IdentifiableObject) -> some View {
        let viewModel = MealsViewModel(service: service, category: category)
        MealsView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}


class MealsAsyncViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncServiceType

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView(item category: any IdentifiableObject) -> some View {
        let viewModel = MealsAsyncViewModel(service: service, category: category)
        MealsView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}


class MealsAsyncStreamViewFactory: ViewBuilderProtocol {

    private let service: MealsAsyncStreamServiceType

    init(service: MealsAsyncStreamServiceType) {
        self.service = service
    }

    @MainActor @ViewBuilder
    func makeView(item category: any IdentifiableObject) -> some View {
        let viewModel = MealsAsyncStreamViewModel(service: service, category: category)
        MealsView(viewModel: viewModel)
    }

    @MainActor
    func makeEmptyView() -> some View {
        makeEmptyView(message: "Select category")
    }
}

// MARK: Mock

extension MealsViewFactory {
    static let mock = MealsViewFactory(service: MealsServicePreview())
}
