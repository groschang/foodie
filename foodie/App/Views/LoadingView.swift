//
//  LoadingView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//

import SwiftUI

struct LoadingView: View {

    private struct Localizable {
        static let loading = "Loading"
    }

    private struct Scale {
        static let start = 1.0
        static let end = 1.3
    }
    
    @State private var textScale: CGFloat = Scale.start
    
    var body: some View {
        VStack(spacing: 50) {
            Text(Localizable.loading)
                .title()
                .foregroundColor(ColorStyle.black.lightOpacity())
                .scaleEffect(textScale)
                .animateForever {
                    textScale = Scale.end
                }
        }
        .maxSize()
        .animatedGradient()
    }
}

// MARK: Previews

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
