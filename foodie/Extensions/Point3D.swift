//
//  Point3D.swift
//  foodie
//
//  Created by Konrad Groschang on 06/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import Spatial
import SwiftUI

extension Point3D {

    public static func +(lhs: Point3D, rhs: Point3D) -> Point3D {
        Point3D(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    public static func +=(left: inout Point3D, right: Point3D) {
        left = left + right
    }

    public static func -(lhs: Point3D, rhs: Point3D) -> Point3D {
        Point3D(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    public static func -=(left: inout Point3D, right: Point3D) {
        left = left - right
    }
}

extension Point3D: @retroactive AdditiveArithmetic {}
extension Point3D: @retroactive VectorArithmetic {

    public mutating func scale(by rhs: Double) {
        self.x *= rhs
        self.y *= rhs
        self.z *= rhs
    }

    public var magnitudeSquared: Double {
        ( pow(x, 2) + pow(y, 2) + pow(z, 2) ).squareRoot()
    }
}

