//
//  PhotoView.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import SwiftUI
import Kingfisher

struct PhotoView: View {

    let imageUrl: URL?

    var body: some View {
        KFImage.url(imageUrl)
            .placeholder {
                PhotoLoadingView()
            }
            .resizable()
    }
}
