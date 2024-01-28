//
//  CoverPhotoView.swift
//  foodie
//
//  Created by Konrad Groschang on 24/01/2023.
//

import SwiftUI
import Kingfisher

struct CoverPhotoView: View {
    
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
    }
}
