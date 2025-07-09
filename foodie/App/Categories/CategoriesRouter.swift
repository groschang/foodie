//
//  CategoriesRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

@MainActor
enum CategoriesRouter: RouterProtocol {

    static var viewFactory: StreamViewFactory {
        get async {
            await DependencyContainer.shared.viewFactory
        }
    }

    case categories
    case empty

    @ViewBuilder
    func makeView() async -> some View {
        switch self {

        case .categories:
            await makeCategoriesView()

        case .empty:
            makeEmptyView()
        }
    }

    private func makeCategoriesView() async -> some View {
        let factory = await Self.viewFactory
        return factory.makeView(type: .categories)
    }

    private func makeEmptyView() -> some View {
        InformationView("Select category")
            .ignoresSafeArea()
    }
}
