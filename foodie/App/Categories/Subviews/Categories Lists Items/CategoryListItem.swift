//
//  CategoryListItem.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import SwiftUI

struct CategoryListItem: View {

    let viewModel: CategoryListItemModel

    var body: some View {
        HStack {
            
            ListPhotoView(imageUrl: viewModel.imageURL)
                .modifier(CategoryListViewPhotoStyle(imageUrl: viewModel.imageURL))
                .clipped()

            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .modifier(CategoryListItemNameStyle())

                Text(viewModel.description)
                    .modifier(CategoryListItemDescriptionStyle())
            }

            Spacer()
        }
        .modifier(BlurredBackground(
            imageUrl: viewModel.imageURL,
            opacity: 0.15)
        )
        .modifier(CategoryListItemStyle())
    }
}


// MARK: Preview

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CategoryListItem(viewModel: .mock)
            CategoryListItem(viewModel: .mock)
            CategoryListItem(viewModel: .mock)
        }
        .padding()
    }
}

