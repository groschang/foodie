//
//  AnimatedCoverPhotoView.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI
import Kingfisher

struct AnimatedCoverPhotoView: View {

    static let duration = 0.4
    static let maxScale: CGFloat = 0.0
    static let minFade: CGFloat = 0.3

    @State private var scale = maxScale
    @State private var faded = true
    @State private var imageLoaded = false

    let imageUrl: URL

    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }

    var body: some View {
        KFImage.url(imageUrl)
            .placeholder {
                PhotoLoadingView()
            }
            .resizable()
            .onSuccess { _ in
                imageLoaded = true
                animate()
            }
            .scaleEffect(scale)
            .opacity(faded ? Self.minFade : 1.0)
            .onAppear {
                if imageLoaded {
                    animate()
                }
            }
            .onDisappear {
                resetAnimation()
            }
    }

    private func animate() {
        withAnimation(.easeIn) {
            scale = 1.0
            faded = false
        }
    }

    private func resetAnimation() {
        scale = Self.maxScale
        faded = true
    }
}


// MARK: Preview

struct CoverPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CoverPhotoView(imageUrl: Meal.stub.imageURL!)
                .modifier(CoverPhotoStyle())
        }
    }
}
