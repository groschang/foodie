//
//  MealsRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

@MainActor
enum MealsRouter: RouterProtocol {

    static var viewFactory: StreamViewFactory {
        get async {
            await DependencyContainer.shared.viewFactory
        }
    }

    case meals(Category)
    case empty

    @ViewBuilder
    func makeView() async -> some View {
        switch self {

        case .meals(let category):
            await makeMealsView(category: category)

        case .empty:
            makeEmptyView()
        }
    }

    private func makeMealsView(category: Category) async -> some View {
        let factory = await Self.viewFactory
        return factory.makeView(type: .meals(category))
    }

    private func makeEmptyView() -> some View {
        InformationView("Select category")
            .ignoresSafeArea()
    }
}
