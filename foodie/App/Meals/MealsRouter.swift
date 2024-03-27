//
//  MealsRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

enum MealsRouter: RouterProtocol {

    static let viewFactory = DependencyContainer.shared.viewFactory

    case meals(Category)

    case empty

    @MainActor @ViewBuilder
    func makeView() -> some View {
        switch self {

        case .meals(let category):
            makeMealsView(category: category)

        case .empty:
            makeEmptyView()
        }
    }

    @MainActor
    private func makeMealsView(category: Category) -> some View {
        Self.viewFactory.makeView(type: .meals(category))
    }

    @MainActor
    private func makeEmptyView() -> some View {
        InformationView("Select category")
            .ignoresSafeArea()
    }
}
