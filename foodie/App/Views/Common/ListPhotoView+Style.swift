//
//  ListPhotoView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ListPhotoStyle: ViewModifier {

    var width: CGFloat = 124
    var height: CGFloat = 124

    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
    }
}


struct BlurredBackground: ViewModifier {

    let imageUrl: URL?
    let blur: CGFloat
    let opacity: CGFloat

    init(imageUrl: URL?, blur: CGFloat = 20, opacity: CGFloat = 0.5) {
        self.imageUrl = imageUrl
        self.blur = blur
        self.opacity = opacity
    }

    func body(content: Content) -> some View {
        content
            .background {
                PhotoView(imageUrl: imageUrl)
                    .scaledToFill()
                    .clipped()
                    .blur(radius: blur)
                    .opacity(opacity)
            }
    }
}
