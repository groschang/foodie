//
//  MealListItem.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MealListItem: View {

    let meal: MealCategory
    
    var body: some View {
        HStack {
            
            ListPhotoView(imageUrl: meal.imageUrl)
                .modifier(MealListItemPhotoStyle())

            Text(meal.name)
                .modifier(MealListItemNameStyle())

            Spacer()
        }
        .modifier(MealListItemStyle())
    }
}

// MARK: Preview

struct MealListItem_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack(spacing: 16) {
            MealListItem(meal: .stub)
            MealListItem(meal: .stub)
            MealListItem(meal: .stub)
        }
        .padding()
        .previewAsComponent()
    }
}
