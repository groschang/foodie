//
//  CategoryView.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import SwiftUI

struct CategoryView: View {

    let viewModel: CategoryViewModel
    
    var body: some View {
        HStack {
            ListPhotoView(imageUrl: viewModel.imageURL)
                .modifier(CategoryViewPhotoStyle(imageUrl: viewModel.imageURL))
                .clipped()
            
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .modifier(CategoryViewNameStyle())
                
                Text(viewModel.description)
                    .modifier(CategoryViewDescriptionStyle())
            }
            
            Spacer()
        }
        .modifier(CategoryViewStyle())
    }
}

// MARK: Preview

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CategoryView(viewModel: .mock)
            CategoryView(viewModel: .mock)
            CategoryView(viewModel: .mock)
        }
        .padding()
    }
}

