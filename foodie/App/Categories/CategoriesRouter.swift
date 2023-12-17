//
//  CategoriesRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

enum CategoriesRouter: RouterProtocol {

    static let viewFactory = CategoriesAsyncViewFactory(service: MealsAsyncService()) //TODO: DI??

    case categories

    case empty

    @MainActor @ViewBuilder
    func makeView() -> some View {
        switch self {

        case .categories:
            makeCategoriesView()

        case .empty:
            makeEmptyView()
        }
    }

    @MainActor @ViewBuilder
    private func makeCategoriesView() -> some View {
        Self.viewFactory.makeView()
    }

    @MainActor
    private func makeEmptyView() -> some View {
        InformationView("Select category")
            .ignoresSafeArea()
    }
}
