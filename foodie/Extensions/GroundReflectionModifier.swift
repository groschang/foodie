//
//  GroundReflectionModifier.swift
//  foodie
//
//  Created by Konrad Groschang on 20/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

private struct GroundReflectionViewModifier: ViewModifier {

    let offsetY: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                content
                    .mask(
                        LinearGradient(
                            gradient: Gradient(
                                stops: [.init(color: .white, location: 0.0),
                                        .init(color: .clear, location: 0.5)]
                            ),
                            startPoint: .bottom,
                            endPoint: .top)
                    )
                    .scaleEffect(x: 1.0, y: -1.0, anchor: .bottom)
                    .opacity(0.3)
                    .offset(y: offsetY)
            )
    }
}

extension View {

    func reflection(offsetY: CGFloat = 1) -> some View {
        modifier(GroundReflectionViewModifier(offsetY: offsetY))
    }

}

struct GroundReflectionViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .reflection()
    }
}
