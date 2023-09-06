//
//  CGPoint.swift
//  foodie
//
//  Created by Konrad Groschang on 05/09/2023.
//

import Foundation
import SwiftUI


extension CGPoint {

    public static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static func +=(left: inout CGPoint, right: CGPoint) {
        left = left + right
    }

    public static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    public static func -=(left: inout CGPoint, right: CGPoint) {
        left = left - right
    }

    func inSize(_ size: CGSize) -> CGPoint {
        let x = x / size.width
        let y = y / size.height
        return CGPoint(x: x, y: y)
    }
}

extension CGPoint: VectorArithmetic {

    public mutating func scale(by rhs: Double) {
        self.x *= rhs
        self.y *= rhs
    }

    public var magnitudeSquared: Double {
        ( pow(x, 2) + pow(y, 2) ).squareRoot()
    }
}
