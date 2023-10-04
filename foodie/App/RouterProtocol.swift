//
//  Router.swift
//  foodie
//
//  Created by Konrad Groschang on 25/09/2023.
//

import SwiftUI

protocol RouterProtocol: Hashable {
    associatedtype V: View
    func makeView() -> V
}

extension View {

    func navigationDestination<T>(for data: T.Type) -> some View where T: RouterProtocol {
        navigationDestination(for: data) { router in
            router.makeView()
        }
    }
}

