//
//  MenuRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

enum MenuRouter: RouterProtocol {

    static let viewFactory = DependencyContainer.shared.viewFactory

    case menu

    @MainActor @ViewBuilder
    func makeView() -> some View {
        
        switch self {

        case .menu:
            Self.viewFactory.makeView(type: .categories)
        }
    }
}
