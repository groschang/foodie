//
//  CategoriesRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

enum CategoriesRouter: RouterProtocol {
    
    static let viewFactory = DependencyContainer.shared.viewFactory
    
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
    
    @MainActor
    private func makeCategoriesView() -> some View {
        Self.viewFactory.makeView(type: .categories)
    }
    
    @MainActor
    private func makeEmptyView() -> some View {
        InformationView("Select category")
            .ignoresSafeArea()
    }
}
