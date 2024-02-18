//
//  Text.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//

import SwiftUI

extension Text {

    func scalableStyle() -> some View {
        lineLimit(1)
            .minimumScaleFactor(0.2)
    }
}
