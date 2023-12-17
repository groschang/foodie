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
                    ListPhotoView(imageUrl: ingredient.smallImageUrl)
                        .frame(width: 40, height: 40)

                    Text(ingredient.name.capitalized)
                        .foregroundColor(ColorStyle.black)
                        .modifier(TextStyle.subtitle2)

                    Spacer()

                    Text("(\(ingredient.measure))")
                        .modifier(TextStyle.subtitle3)
                        .foregroundColor(ColorStyle.gray)
//                        .italic()
                }
            }
            .padding(.leading)
        }
    }
}

// MARK: Preview

struct IngredientsView_Previews: PreviewProvider {

    static let ingredients: [Ingredient] = [
        Ingredient(name: "Orange", measure: "22 kg"),
        Ingredient(name: "garlic sauce", measure: "4 cups"),
    ]

    static var previews: some View {
        IngredientsView(ingredients)
                .previewAsComponent()
    }
}
