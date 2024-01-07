//
//  MenuViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//

import SwiftUI

class MenuViewFactory: ViewBuilderProtocol {

    @MainActor @ViewBuilder
    func makeView() -> some View {
        MenuView()
    }
}

