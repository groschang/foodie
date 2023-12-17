//
//  LoadingView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//

import SwiftUI

struct LoadingView: View {

    @State private var textScale = 1.0
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Loading")
                .modifier(TextStyle.infoScreenTitle)
                .scaleEffect(textScale)
                .animateForever {
                    textScale = 1.3
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
