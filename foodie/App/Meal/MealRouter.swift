//
//  MealRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

enum MealRouter: RouterProtocol {
    
    static var viewFactory: StreamViewFactory {
        get async {
            await DependencyContainer.shared.viewFactory
        }
    }

    case meal(MealCategory)
    
    @ViewBuilder @MainActor
    func makeView() async -> some View {
        switch self {
            
        case .meal(let meal):
            let factory = await Self.viewFactory
            factory.makeView(type: .meal(meal))
        }
    }
}
