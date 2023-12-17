//
//  MealRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

enum MealRouter: RouterProtocol {
    
    static let viewFactory = DependencyContainer.shared.viewFactory
    
    case meal(MealCategory)
    
    @MainActor @ViewBuilder
    func makeView() -> some View {
        switch self {
            
        case .meal(let meal):
            makeMealView(meal: meal)
        }
    }
    
    @MainActor
    private func makeMealView(meal: MealCategory) -> some View {
        Self.viewFactory.makeView(type: .meal(meal))
    }
}
