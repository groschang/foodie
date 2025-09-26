//
//  CategoryGridItem.swift
//  foodie
//
//  Created by Konrad Groschang on 20/03/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

enum CategoriesGridFont: CGFloat {
    case small = 20
    case normal = 34
}


struct CategoryGridItem: View {

    let viewModel: CategoryItemViewModel

    let fontType: CategoriesGridFont

    private var halfOverlay: Bool {
        fontType == .normal
    }

    init(viewModel: CategoryItemViewModel, fontType: CategoriesGridFont = .normal) {
        self.viewModel = viewModel
        self.fontType = fontType
    }

    var body: some View {
        ZStack {

            ListPhotoView(imageUrl: viewModel.imageURL)
                .aspectRatio(contentMode: .fit)

            VStack { 
                if halfOverlay {
                    Spacer()
                }

                Text(viewModel.name)
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
                    .overlaySize(fullscreen: halfOverlay)
                    .padding()
                    .background(Color.black.heavyOpacity())

            }
        }
        .modifier(CategoryListItemStyle())
    }
}


fileprivate extension View {

    @ViewBuilder
    func overlaySize(fullscreen: Bool) -> some View {
        if fullscreen {
            self
        } else {
            self.maxHeight()
        }
    }

}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        CategoryGridItem(viewModel: .mock)
        CategoryGridItem(viewModel: .mock)
        CategoryGridItem(viewModel: .mock)
    }
    .padding()
}

// MARK: - Preview

#Preview {
    LazyVGrid(
        columns: [GridItem(.adaptive(minimum: 140))],
        spacing: 20
    ) {
        CategoryGridItem(viewModel: .mock, fontType: .normal)
        CategoryGridItem(viewModel: .mock, fontType: .small)
        CategoryGridItem(viewModel: .mock, fontType: .normal)
        CategoryGridItem(viewModel: .mock, fontType: .small)
        CategoryGridItem(viewModel: .mock, fontType: .normal)
    }
    .padding()
}
