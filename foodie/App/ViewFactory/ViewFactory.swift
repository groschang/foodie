//
//  ViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 03/10/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

protocol ViewFactoryType {
    associatedtype V : View
    @MainActor func makeView(type: Route) -> V
}

extension View {

    func makeNavigation<ViewFactory>(
        with viewFactory: ViewFactory
    ) -> some View
    where ViewFactory: ViewFactoryType {

        navigationDestination(for: Route.self) { route in
            viewFactory.makeView(type: route)
        }
    }
}


// MARK: Default View Factory

class ViewFactory: StreamViewFactory { }


// MARK: Mock

extension ViewFactory {
    static let mock = ClosureViewFactory(service: MealsServicePreview())
}
