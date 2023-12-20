//
//  PhotoLoadingView.swift
//  foodie
//
//  Created by Konrad Groschang on 24/01/2023.
//

import SwiftUI

struct PhotoLoadingView: View {
    
    var body: some View {
        ProgressView()
            .modifier(PhotoLoadingViewStyle())
    }
}

// MARK: Preview

struct PhotoPlaceholder_Peviews: PreviewProvider {
    static var previews: some View {
        PhotoLoadingView()
    }
}
