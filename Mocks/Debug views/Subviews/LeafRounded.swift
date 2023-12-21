//
//  LeafRounded.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//

import SwiftUI

extension View {
    
    static var leafCornerRadius: CGFloat { 20.0 }
    
    static var leafCorners: UIRectCorner { [.bottomLeft, .topRight] }
    
    static var leafBoarderColor: Color { .gray }
    
    
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
    
    static var leafShape: UnevenRoundedRectangle {
        .rect(
            topLeadingRadius: 0,
            bottomLeadingRadius: Self.leafCornerRadius,
            bottomTrailingRadius: 0,
            topTrailingRadius: Self.leafCornerRadius
        )
    }
}
