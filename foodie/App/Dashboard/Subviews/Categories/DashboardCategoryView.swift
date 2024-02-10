//
//  DashboardCategoryView.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

struct DashboardCategoryView: View {

    let category: Category

    var body: some View {
        Text(category.name)
            foregroundStyle(AppStyle.white)
            .bold()
            .subtitle()
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(AppStyle.gray)
            .clipShape(Capsule())
    }
}



struct DashboardCategoryVerticalView: View {

    let category: Category

    var body: some View {
        VStack(spacing: 0) {
            ListPhotoView(imageUrl: category.imageUrl)
                .modifier(
                    CategoryListViewPhotoStyle(
                        width: 62,
                        height: 62,
                        imageUrl: category.imageUrl
                    )
                )
                .clipShape(Circle())

            Text(category.name)
                .subtitle2()
                .minimumScaleFactor(0.7)
        }
    }
}



struct DashboardCategoryHorizontalView: View {

    let category: Category

    var body: some View {
        HStack {
            ListPhotoView(imageUrl: URL.SmallImage(category.imageUrl) )
                .modifier(
                    ListPhotoStyle(
                        width: 62,
                        height: 62
                    )
                )
                .background(.white)
                .clipShape(Circle())

            Text(category.name)
                foregroundStyle(AppStyle.white)
                .bold()
                .subtitle()

        }
        .padding(8)
        .background(AppStyle.main)
        .clipShape(Capsule())
    }
}

// MARK: Preview

struct DashboardCategoryView_Preview: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32) {
            DashboardCategoryView(category: .mock)
            DashboardCategoryVerticalView(category: .mock)
            DashboardCategoryHorizontalView(category: .mock)
        }
    }
}
