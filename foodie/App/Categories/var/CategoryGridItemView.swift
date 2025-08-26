//
//  CategoryGridItemView.swift
//  foodie
//
//  Created by Konrad Groschang on 20/03/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI
import Kingfisher

struct CategoryGridItemView: View {
    
    let category: Category
    
    var description: String {
        category.description
            .removeWhitespaces()
            .trunc(to: ".", ifExists: true, appendingTruced: true)
            .trunc(120)
    }
    
    var body: some View {
        VStack {
            ListPhotoView(imageUrl: category.imageUrl)
                .modifier(CategoryGridPhotoStyle())
            
            Text(category.name)
                .modifier(CategoryGridTextStyle())
        }
    }
}

// MARK: Preview

struct CategoryGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridItemView(category: .stub)
    }
}

// MARK: Styles

struct CategoryGridTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundStyle(AppStyle.black)
            .shadow(color: .white ,radius: 1)
    }
}


struct CategoryGridPhotoStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
        //            .frame(width: 87, height: 87)
            .frame(height: 90)
            .frame(maxWidth: .infinity)
            .background {
                Color.white
                    .cornerRadius(6)
                    .shadow(color: .black.heavierOpacity(), radius: 5)
                    .transition(.slide)
                    .opacity(0.6)
            }
    }
}
