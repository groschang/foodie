//
//  ImageBackgroundStyle.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ImageBackgroundStyle: ViewModifier {

    private struct Blur {
        static let radius = 90.0
    }

    let imageUrl: URL?
    
    init(_ imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    func body(content: Content) -> some View {
        content
            .background {
                if let imageUrl {
                    PhotoView(imageUrl: imageUrl)
                        .scaledToFill()
                        .clipped()
                        .blur(radius: Blur.radius)
                }
            }
    }
}
