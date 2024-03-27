//
//  Animation.swift
//  foodie
//
//  Created by Konrad Groschang on 24/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

extension View {

    func animate(using animation: Animation = .easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
        onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }

    func animateForever(using animation: Animation = .easeInOut(duration: 2), autoreverses: Bool = true, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)

        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}

extension View {

    func animateAppear(_ value: Binding<Double>, index: Int = .zero) -> some View {
        opacity(value.wrappedValue)
            .animate(
                using: Animation
                    .easeInOut(duration: 2)
                    .delay(0.2 * Double(index))
            ) {
                value.wrappedValue = 1.0
            }
    }
}

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .delay(0.1 * Double(index))
    }

    static func appear(index: Int) -> Animation {
        Animation.easeInOut
            .delay(0.1 * Double(index))
    }
}
