//
//  Shadow.swift
//  foodie
//
//  Created by Konrad Groschang on 06/01/2024.
//

import SwiftUI

extension View {

    func defaultShadow(
        color: Color = AppStyle.shadow.color,
        radius: CGFloat = AppStyle.shadowRadius,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) -> some View {
        shadow(color: color, radius: radius, x: x, y: y)
    }
    
}
