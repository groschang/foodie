//
//  Text.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

extension Text {

    func scalableStyle() -> some View {
        lineLimit(1)
            .minimumScaleFactor(0.2)
    }
}
