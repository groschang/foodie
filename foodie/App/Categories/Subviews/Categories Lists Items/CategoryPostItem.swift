//
//  CategoryPostItem.swift
//  foodie
//
//  Created by Konrad Groschang on 9/24/25.
//

import SwiftUI

struct CategoryPostItem: View {

    let viewModel: CategoryItemViewModel

    var body: some View {
        HStack {

            ListPhotoView(imageUrl: viewModel.imageURL)
                .modifier(CategoryPostViewPhotoStyle(imageUrl: viewModel.imageURL))
                .clipped()

            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .modifier(CategoryPostItemNameStyle())

                Text(viewModel.description)
                    .modifier(CategoryPostItemDescriptionStyle())

            }

            Spacer()
        }
        .modifier(BlurredBackground(
            imageUrl: viewModel.imageURL,
            opacity: 0.15)
        )
        .modifier(CategoryPostItemStyle())
    }
}

// MARK: - Preview

#Preview {
    VStack {
        CategoryPostItem(viewModel: .mock)
        CategoryPostItem(viewModel: .mock)
        CategoryPostItem(viewModel: .mock)
    }
    .padding()
}
