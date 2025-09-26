//
//  Angle.swift
//  foodie
//
//  Created by Konrad Groschang on 05/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//  All rights reserved.

import SwiftUI

extension Angle {
    
    static func degrees(_ degrees: Double, limit: Double) -> Angle {
        .degrees(.init(degrees, limit: limit))
    }
}
