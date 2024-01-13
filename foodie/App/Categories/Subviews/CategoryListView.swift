//
//  CategoryListView.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import SwiftUI

struct CategoryListView: View {

    let viewModel: CategoryListViewModel

    var body: some View {
        HStack {
            
            ListPhotoView(imageUrl: viewModel.imageURL)
                .modifier(CategoryListViewPhotoStyle(imageUrl: viewModel.imageURL))
                .clipped()

            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .modifier(CategoryViewNameStyle())

                Text(viewModel.description)
                    .modifier(CategoryViewDescriptionStyle())
            }

            Spacer()
        }
        .modifier(BlurredBackground(
            imageUrl: viewModel.imageURL,
            opacity: 0.15)
        )
        .modifier(CategoryListViewStyle())
    }
}

// MARK: Preview

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CategoryListView(viewModel: .mock)
            CategoryListView(viewModel: .mock)
            CategoryListView(viewModel: .mock)
        }
        .padding()
    }
}

