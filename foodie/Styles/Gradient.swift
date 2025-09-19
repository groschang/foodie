//
//  FoodieGradient.swift
//  foodie
//
//  Created by Konrad Groschang on 27/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

// MARK: StaticGradient

struct StaticGradient: View {

    private static let opacity = 0.2

    var body: some View {
        FoodieGradient()
            .opacity(StaticGradient.opacity)
    }
}

extension View {
    func staticGradient() -> some View  {
        background { StaticGradient()}
    }
}

// MARK: FoodieGradient

struct FoodieGradient: View {

    private struct Colors {
        static let gradient = [Color.white, Color.blue, Color.white]
    }

    private struct Angles {
        static let start = Double.zero
        static let end = 360.0
    }

    private struct Blur {
        static let radius = 66.0
    }
    
    var body: some View {
        AngularGradient(
            gradient: Gradient(
                colors: Colors.gradient
            ),
            center: .center,
            startAngle: .degrees(Angles.start),
            endAngle: .degrees(Angles.end)
        )
        .blur(radius: Blur.radius)
    }
}

extension View {
    func foodieGradient() -> some View  {
        background { FoodieGradient()}
    }
}


// MARK: AnimatedGradient

struct AnimatedGradient: View {

    private struct Opacity {
        static let start = 0.14
        static let end = 0.42
    }
    
    @State private var opactity = Opacity.start
    
    var body: some View {
        FoodieGradient()
            .opacity(opactity)
            .animateForever {
                opactity = Opacity.end
            }
    }
}

extension View {
    func animatedGradient() -> some View  {
        background { AnimatedGradient()}
    }
}


// MARK: Side Gradient

struct SideGradient: View {

    private struct Colors {
        static let gradient = Color.black
    }

    private struct Locations {
        static let start = Double.zero
        static let end = 0.5
    }

    private struct Opacity {
        static let start = Double.zero
        static let end = 1.0
    }

    let startPoint: UnitPoint

    var location: CGFloat = Locations.end

    var body: some View {
        LinearGradient(gradient:
                        Gradient(stops:
                                    [.init(color: Colors.gradient.opacity(Opacity.start), location: Locations.start),
                                     .init(color: Colors.gradient.opacity(Opacity.end), location: location)]
                                ),
                       startPoint: startPoint,
                       endPoint: .center)
    }
}

extension View {
    func sideGradient(startPoint: UnitPoint, location: CGFloat = .zero) -> some View {
        background { SideGradient(startPoint: startPoint, location: location) }
    }
}

// MARK: Previews

#Preview("Base") {
    FoodieGradient()
}

#Preview("Static") {
    StaticGradient()
}

#Preview("Animated") {
    AnimatedGradient()
}

#Preview("Side") {
    SideGradient(startPoint: .leading)
}


