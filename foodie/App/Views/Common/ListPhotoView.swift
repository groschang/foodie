//
//  ListPhotoView.swift
//  foodie
//
//  Created by Konrad Groschang on 24/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI
import Kingfisher  //TODO: 

struct ListPhotoView<LoadingViewContent: View>: View {

    private var imageUrl: URL?
    private var loadingView: LoadingViewContent?

    @State private var appeared = false

    init(imageUrl: URL? = nil) where LoadingViewContent == PhotoLoadingView {
        self.imageUrl = imageUrl
    }

    init(imageUrl: URL? = nil, @ViewBuilder loadingView: @escaping () -> LoadingViewContent) {
        self.imageUrl = imageUrl
        self.loadingView = loadingView()
    }

    var body: some View {
        content
            .opacity(appeared ? 1.0 : .zero)
            .onAppear {
                withAnimation(.easeIn) {
                    appeared = true
                }
            }
    }
//TODO: 
//    func loadingView(@ViewBuilder _ content: @escaping () -> LoadingViewContent) -> Self {
//        self.loadingView = content()
//        return self
//    }


    @ViewBuilder
    private var content: some View {
        if imageUrl.isNotNil {
            photo
        } else {
            PhotoPlaceholderView()
        }
    }

    private var photo: some View {
        KFImage.url(imageUrl)
            .placeholder {
                if let loadingView {
                    loadingView
                } else {
                    PhotoLoadingView()
                }
            }
            .resizable()
            .fade(duration: 0.25)
    }
}





