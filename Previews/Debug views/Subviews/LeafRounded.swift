//
//  LeafRounded.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

extension View {
    
    static var leafCornerRadius: CGFloat { AppStyle.cornerRadius }

    static var leafBoarderColor: Color { .gray }

    static var leafCorners: UIRectCorner { [.topLeft, .bottomRight] }

    func leafShaped() -> some View {
        leafRounded()
            .leafRounderBorder()
    }
    
    func leafRounded() -> some View {
        
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            return clipShape(UnevenRoundedRectangle.leafShape)
        } else {
            return cornerRadius(Self.leafCornerRadius, corners: Self.leafCorners)
        }
    }
    
    func leafRounderBorder() -> some View {
        
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            
            return overlay {
                UnevenRoundedRectangle.leafShape
                    .stroke(Self.leafBoarderColor, lineWidth: 2)
            }
            
        } else {
            
            return overlay {
                RoundedCorner(
                    radius: Self.leafCornerRadius,
                    corners: Self.leafCorners
                )
                .stroke(Self.leafBoarderColor, lineWidth: 2)
            }
        }
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Shape where Self == UnevenRoundedRectangle {

    @MainActor
    static var leafShape: UnevenRoundedRectangle {
        .rect(
            topLeadingRadius: Self.leafCornerRadius,
            bottomLeadingRadius: .zero,
            bottomTrailingRadius: Self.leafCornerRadius,
            topTrailingRadius: .zero
        )
    }
}


extension View {

    static var reversedLeafCorners: UIRectCorner { [.bottomLeft, .topRight] }

    func reversedLeafShaped() -> some View {
        reversedLeafRounded()
            .reversedLeafRounderBorder()
    }

    func reversedLeafRounded() -> some View {

        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            return clipShape(UnevenRoundedRectangle.reversedLeafShape)
        } else {
            return cornerRadius(Self.leafCornerRadius, corners: Self.reversedLeafCorners)
        }
    }

    func reversedLeafRounderBorder() -> some View {

        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {

            return overlay {
                UnevenRoundedRectangle.reversedLeafShape
                    .stroke(Self.leafBoarderColor, lineWidth: 2)
            }

        } else {

            return overlay {
                RoundedCorner(
                    radius: Self.leafCornerRadius,
                    corners: Self.reversedLeafCorners
                )
                .stroke(Self.leafBoarderColor, lineWidth: 2)
            }
        }
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Shape where Self == UnevenRoundedRectangle {

    @MainActor
    static var reversedLeafShape: UnevenRoundedRectangle {
        .rect(
            topLeadingRadius: .zero,
            bottomLeadingRadius: Self.leafCornerRadius,
            bottomTrailingRadius: .zero,
            topTrailingRadius: Self.leafCornerRadius
        )
    }
}
