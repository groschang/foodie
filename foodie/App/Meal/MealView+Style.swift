//
//  MealView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MealViewStyle: ViewModifier {

    private struct Blur {
        static let min = 25.0
        static let multiplier = 0.7
    }

    private struct Opacity {
        static let dividend = 87.0
    }

    let backgroundUrl: URL?

    let offset: CGFloat

    @Binding var imageSize: CGRect

    private var blur: CGFloat { min(offset * Blur.multiplier, Blur.min) }
    private var opacity: CGFloat { Opacity.dividend / max(offset, .zero) }

    func body(content: Content) -> some View {
        content
            .background {
                if let backgroundUrl {
                    VStack(spacing: .zero) {

                        CoverPhotoView(imageUrl: backgroundUrl)
                            .readingGeometry(from: CoordinateSpace.main, into: $imageSize)
                            .modifier(MealViewImageStyle())
                            .blur(radius: blur)
                            .opacity(opacity)

                        Spacer()
                    }
                    .coordinateSpace(name: CoordinateSpace.image)
                }
            }
    }
}



struct MealViewImageStyle: ViewModifier {
    
    @MainActor
    private struct Shadow {
        static let color = Color.shadow
        static let radius = 24.0
        static let x = 0.0
        static let y = 24.0
    }

    private struct Layouts {
        static let height = 500.0
    }

    func body(content: Content) -> some View {
        content
            .clipped()
            .scaledToFill()
            .frame(height: Layouts.height)
            .shadow(color: Shadow.color,
                    radius: Shadow.radius,
                    x: Shadow.x,
                    y: Shadow.y)
            .edgesIgnoringSafeArea(.top)
    }
}
