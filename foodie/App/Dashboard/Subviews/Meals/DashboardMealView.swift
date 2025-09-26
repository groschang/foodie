//
//  DashboardMealView.swift
//  foodie
//
//  Created by Konrad Groschang on 10/02/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct DashboardMealView: View {

    static let size = CGSize(width: 100, height: 100)

    let meal: Meal

    var body: some View {
        VStack(spacing: 8) {

            ListPhotoView(imageUrl: meal.imageURL)
                .modifier(
                    CategoryListViewPhotoStyle(
                        width: Self.size.width,
                        height: Self.size.height,
                        imageUrl: meal.imageURL
                    )
                )
                .cornerRadius(10)
                .shadow(radius: 5)

            Text(meal.name)
                .foregroundStyle(Color.accent)
                .subtitle2()
                .lineLimit(3)
                .multilineTextAlignment(.center)
        }
        .frame(width: Self.size.width)

    }
}

// MARK: - Preview

#Preview {
    DashboardMealView(meal: .stub)
}
