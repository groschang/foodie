//
//  ParallaxMotionModifier.swift
//  foodie
//
//  Created by Konrad Groschang on 05/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ParallaxMotionModifier: ViewModifier {

    @ObservedObject var manager: ParallaxManager

    var magnitude: Double

    let degreesLimit = 30.0

    func body(content: Content) -> some View {

        let x = manager.position.x * magnitude //TODO: scale(by: 
        let xRotation: Angle = .degrees(x, limit: degreesLimit)
        let y = manager.position.y * magnitude
        let yRotation: Angle = .degrees(y, limit: degreesLimit)
        let z = manager.position.z * magnitude
        let zRotation: Angle = .degrees(z, limit: degreesLimit)

        content
            .rotation3DEffect(xRotation, axis: Axis.x)
            .rotation3DEffect(yRotation, axis: Axis.y)
            .rotation3DEffect(zRotation, axis: Axis.z)
    }
}


extension ParallaxMotionModifier {
    
    struct Axis {
        typealias Tuple = (x: CGFloat, y: CGFloat, z: CGFloat)

        static let x: Tuple = (x: 1, y: 0, z: 0)
        static let y: Tuple = (x: 0, y: 1, z: 0)
        static let z: Tuple = (x: 0, y: 0, z: 1)
    }

}
