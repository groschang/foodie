//
//  ParallaxShadowModifier.swift
//  foodie
//
//  Created by Konrad Groschang on 05/09/2023.
//

import SwiftUI

struct ParallaxShadowModifier: ViewModifier {

    @ObservedObject var manager: ParallaxManager

    var radius = 5.0

    var magnitude: Double

    let offsetLimit = 20.0

    func body(content: Content) -> some View {
        content
            .shadow(
                radius: radius,
                x: Double(manager.position.x * magnitude, limit: offsetLimit),
                y: Double(manager.position.y * -magnitude, limit: offsetLimit)
            )
    }
}
