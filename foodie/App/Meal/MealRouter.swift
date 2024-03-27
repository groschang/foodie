//
//  MealRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

enum MealRouter: RouterProtocol {
    
    static let viewFactory = DependencyContainer.shared.viewFactory
    
    case meal(MealCategory)
    
    @MainActor @ViewBuilder
    func makeView() -> some View {
        switch self {
            
        case .meal(let meal):
            Self.viewFactory.makeView(type: .meal(meal))
        }
    }
}
