//
//  CoverPhotoView.swift
//  foodie
//
//  Created by Konrad Groschang on 24/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
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
