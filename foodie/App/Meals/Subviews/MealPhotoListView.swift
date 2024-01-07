//
//  MealPhotoListView.swift
//  foodie
//
//  Created by Konrad Groschang on 23/12/2023.
//

import SwiftUI

enum MealPhotoListFont: CGFloat {
    case small = 20
    case normal = 34
}

struct MealPhotoListView: View {

    let meal: MealCategory

    let fontType: MealPhotoListFont

    init(meal: MealCategory, fontType: MealPhotoListFont = .normal) {
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
//                    .padding(.bottom)
                    .background(Color.black.heavyOpacity())
            }
        }
        .modifier(MealListStyle())
    }
}

// MARK: Preview

struct MealPhotoListView_Previews: PreviewProvider {
    static var previews: some View {

        VStack(spacing: 16) {
            MealPhotoListView(meal: .mock)
            MealPhotoListView(meal: .mock)
            MealPhotoListView(meal: .mock)
        }
        .padding()
        .previewAsComponent()
    }
}

