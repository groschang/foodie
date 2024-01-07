//
//  MealListView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//

import SwiftUI

struct MealListView: View {
    
    let meal: MealCategory
    
    var body: some View {
        HStack {
            
            ListPhotoView(imageUrl: meal.imageUrl)
                .modifier(MealListPhotoStyle())
            
            Text(meal.name)
                .modifier(MealListNameStyle())
            
            Spacer()
        }
        .modifier(MealListStyle())
    }
}

// MARK: Preview

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack(spacing: 16) {
            MealListView(meal: .mock)
            MealListView(meal: .mock)
            MealListView(meal: .mock)
        }
        .padding()
        .previewAsComponent()
    }
}
