//
//  LoadingView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct LoadingView: View {

    @State private var textScale = 1.0
    
    var body: some View {
        VStack(spacing: 50) {
            ModernCircularLoader()
        }
        .maxSize()
        .animatedGradient()
    }
}


struct ModernCircularLoader: View {
    @State private var trimEnd = 0.6
    @State private var animate = false

    var body: some View {
        Circle()
            .trim(from: 0.0,to: trimEnd)
            .stroke(
                .tint,
                style: StrokeStyle(
                    lineWidth: 7,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            .animation(
                Animation.easeIn(duration: 1.5)
                    .repeatForever(autoreverses: true),
                value: trimEnd
            )
            .frame(width: 70, height: 70)
            .rotationEffect(Angle(degrees: animate ? 270 + 360 : 270))
            .animation(
                Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear{
                animate = true
                trimEnd = 0
            }
            .opacity(0.6)
    }
}

// MARK: - Previews

#Preview {
    LoadingView()
}
