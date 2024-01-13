//
//  CategoriesGridView.swift
//  foodie
//
//  Created by Konrad Groschang on 20/03/2023.
//

import SwiftUI

enum CategoriesGridFont: CGFloat {
    case small = 20
    case normal = 34
}

struct CategoriesGridView: View {

    let viewModel: CategoryListViewModel

    let fontType: CategoriesGridFont

    private var halfOverlay: Bool {
        fontType == .normal
    }

    init(viewModel: CategoryListViewModel, fontType: CategoriesGridFont = .normal) {
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
        .modifier(CategoryListViewStyle())
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

// MARK: Preview

struct CategoriesPhotoView_Previews: PreviewProvider {
    static var previews: some View {

        VStack(spacing: 16) {
            CategoriesGridView(viewModel: .mock)
            CategoriesGridView(viewModel: .mock)
            CategoriesGridView(viewModel: .mock)
        }
        .padding()
    }
}

struct CategoriesGridView_Previews: PreviewProvider {
    static var previews: some View {

        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 140))],
            spacing: 20
        ) {
            CategoriesGridView(viewModel: .mock, fontType: .normal)
            CategoriesGridView(viewModel: .mock, fontType: .small)
            CategoriesGridView(viewModel: .mock, fontType: .normal)
            CategoriesGridView(viewModel: .mock, fontType: .small)
            CategoriesGridView(viewModel: .mock, fontType: .normal)
        }
        .padding()
    }
}
