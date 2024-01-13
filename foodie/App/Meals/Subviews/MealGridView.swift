//
//  MealGridView.swift
//  foodie
//
//  Created by Konrad Groschang on 23/12/2023.
//

import SwiftUI

enum MealGridFont: CGFloat {
    case small = 20
    case normal = 34
}

struct MealGridView: View {

    let meal: MealCategory

    let fontType: MealGridFont

    init(meal: MealCategory, fontType: MealGridFont = .normal) {
        self.meal = meal
        self.fontType = fontType
    }

    var body: some View {
        ZStack {

            ListPhotoView(imageUrl: meal.imageUrl)
                .aspectRatio(contentMode: .fill)

            VStack {
                Spacer()

                Text(meal.name)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.2)
                    .font(
                        .custom(
                            "AmericanTypewriter", //TODO: #font
                            fixedSize: fontType.rawValue )
                        .weight(.semibold)

                    )
                    .foregroundStyle(Color.white)
                    .maxWidth()
                    .padding()
                    .background(Color.black.heavyOpacity())
            }
        }
        .modifier(MealListStyle())
    }
}

// MARK: Preview

struct MealGridView_Previews: PreviewProvider {
    static var previews: some View {

        VStack(spacing: 16) {
            MealGridView(meal: .mock)
            MealGridView(meal: .mock)
            MealGridView(meal: .mock)
        }
        .padding()
        .previewAsComponent()
    }
}
