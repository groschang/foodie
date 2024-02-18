//
//  MealView.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import SwiftUI

struct MealView<Model>: View where Model: MealViewModelType {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject private var viewModel: Model
    
    @State private var offset: CGPoint = .zero
    @State private var imageSize: CGRect = .zero
    @State private var contentSize: CGRect = .zero
    @State private var scrollViewSize: CGRect = .zero

    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        AsyncContentView(source: viewModel, content: content)
            .hideNavigationBar()
            .coordinateSpace(name: CoordinateSpace.main)
            .readingGeometry(from: CoordinateSpace.main, into: $contentSize)
            .overlay {
                ElipseBackButton() { presentationMode.wrappedValue.dismiss() }
                    .placeAtTheTop()
                    .placeAtTheLeft()
                    .padding()
            }
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                    viewModel.jeb()
//                    offset.y += 100
//                }
//            }
    }
    
    var content: some View {
        ScrollView(showsIndicators: false) {

            VStack(spacing: 21) {
                spacer
                informations
                ingredients
                recipe
                youtube
                source
            }
            .readScrollView(from: CoordinateSpace.main, into: $offset)
            .readingGeometry(from: CoordinateSpace.main, into: $scrollViewSize)
            .padding(.horizontal)
        }
        .modifier(MealViewStyle(backgroundUrl: viewModel.backgroundUrl,
                                offset: offset.y + contentSize.minY,
                                imageSize: $imageSize))

    }

    private var spacer: some View {
        Spacer(minLength: imageSize.maxY - abs(contentSize.minY))
    }
    
    private var informations: some View {
        MealInformationView(viewModel: viewModel)
    }
    
    @ViewBuilder
    private var ingredients: some View {
        if let ingredients = viewModel.ingredients {
            VStack {
                ExtendedTitleView(viewModel.ingredientsTitle,
                                  style: MealViewIngredientTitleStyle(),
                                  subtitle: viewModel.ingredientsSubtitle,
                                  subtitleStyle: MealViewIngredientSubitleStyle())

                IngredientsView(ingredients)
            }
        }
    }

    private var recipe: some View {
        VStack(alignment: .leading) {
            TitleView(viewModel.recipeTitle, style: MealViewIngredientTitleStyle())
            MultilineTextView(viewModel.recipe)
        }
    }

    @ViewBuilder
    private var youtube: some View {
        if let link = viewModel.youtubeUrl {
            YouTubeView(url: link)
                .frameWithRatio16to9(scrollViewSize.width)
        }
    }

    @ViewBuilder
    private var source: some View {
        if let link = viewModel.source {
            Link("Link to the website", destination: link)
                .modifier(MealViewSourceStyle())
        }
    }
}

// MARK: Preview

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MocksPreview(mocks: MealViewModel.mocks,
                     type: MealViewModelMock.self) { mock in
            NavigationView {
                MealView(viewModel: mock)
            }
        }
    }
}
