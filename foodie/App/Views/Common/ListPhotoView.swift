//
//  ListPhotoView.swift
//  foodie
//
//  Created by Konrad Groschang on 24/01/2023.
//

import SwiftUI
import Kingfisher

struct ListPhotoView: View {
    
    static let duration = 0.2
    static let minFade: CGFloat = 0.0

    @State private var faded = true
    @State private var imageLoaded = false
    
    var imageUrl: URL?
    
    var body: some View {
        if let imageUrl {
            KFImage.url(imageUrl)
                .placeholder {
                    PhotoPlaceholder()
                }
                .resizable()
                .onSuccess { _ in
                    imageLoaded = true
                    animate()
                }
                .opacity(faded ? Self.minFade : 1.0)
                .onAppear {
                    animate()
                }
                .onDisappear {
                    resetAnimation()
                }
        }
    }
    
    private func animate() {
        guard imageLoaded else { return }
        
        withAnimation(.linear) {
            faded = false
        }
    }
    
    private func resetAnimation() {
        faded = true
    }
}
