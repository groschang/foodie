//
//  Animation.swift
//  foodie
//
//  Created by Konrad Groschang on 24/01/2023.
//

import SwiftUI

extension View {
    
    func animateForever(using animation: Animation = .easeInOut(duration: 2.4), autoreverses: Bool = true, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)

        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}
