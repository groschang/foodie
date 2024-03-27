//
//  MenuViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

class MenuViewFactory: ViewBuilderProtocol {

    @MainActor @ViewBuilder
    func makeView() -> some View {
        MenuView()
    }
}

