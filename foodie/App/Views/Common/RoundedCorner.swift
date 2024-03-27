//
//  RoundedCorner.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        Path(
            UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            ).cgPath
        )
    }
}

extension View {

    func defaultCornerRadius(_ radius: CGFloat = AppStyle.cornerRadius, corners: UIRectCorner) -> some View {
        cornerRadius(radius, corners: corners)
    }

    @ViewBuilder
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {

        if #available(iOS 16, *) {

            clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: corners.contains(.topLeft) ? radius : .zero,
                    bottomLeadingRadius: corners.contains(.bottomLeft) ? radius : .zero,
                    bottomTrailingRadius: corners.contains(.bottomRight) ? radius : .zero,
                    topTrailingRadius: corners.contains(.topRight) ? radius : .zero,
                    style: .continuous
                )
            )

        } else {

            clipShape(
                RoundedCorner(
                    radius: radius,
                    corners: corners
                )
            )

        }
    }
}
