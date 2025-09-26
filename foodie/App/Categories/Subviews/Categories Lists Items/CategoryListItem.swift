//
//  CategoryListItem.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct CategoryListItem: View {

    let viewModel: CategoryItemViewModel

    var body: some View {
        HStack {
            
            ListPhotoView(imageUrl: viewModel.imageURL)
                .modifier(CategoryListViewPhotoStyle(imageUrl: viewModel.imageURL))
                .clipped()
                .padding(.leading, 6)

            Text(viewModel.name)
                .modifier(CategoryListItemNameStyle())

            Spacer()
        }
        .modifier(BlurredBackground(
            imageUrl: viewModel.imageURL,
            opacity: 0.15)
        )
        .modifier(CategoryListItemStyle())
    }
}

// MARK: - Preview

#Preview {
    VStack {
        CategoryListItem(viewModel: .mock)
        CategoryListItem(viewModel: .mock)
        CategoryListItem(viewModel: .mock)
    }
    .padding()
}

