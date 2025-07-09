//
//  MenuRouter.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

enum MenuRouter: RouterProtocol {

    static var viewFactory: StreamViewFactory {
        get async {
            await DependencyContainer.shared.viewFactory
        }
    }
    case menu

    @MainActor @ViewBuilder
    func makeView() async -> some View {

        switch self {

        case .menu:
            let factory = await Self.viewFactory
            factory.makeView(type: .categories)
        }
    }
}
