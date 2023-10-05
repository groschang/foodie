//
//  IngredientsView.swift
//  foodie
//
//  Created by Konrad Groschang on 08/02/2023.
//

import SwiftUI

struct IngredientsView: View {
    
    let ingredients: [Ingredient]
    
    init(_ ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }
    
    var body: some View {
        VStack {
            ForEach(ingredients, id: \.self) { ingredient in
                
                HStack {
                    Text(ingredient.name)
                        .bold()
                    Text("(\(ingredient.measure))")
                        .italic()
                }
            }
        }
    }
}

// MARK: Preview

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView(MealDetail.mock.ingredients!)
            .previewAsComponent()
    }
}
