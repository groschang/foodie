//
//  MealView.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import SwiftUI

struct MealView<Model>: View where Model: MealViewModelType {

    @EnvironmentObject var router: Router

    @ObservedObject private var viewModel: Model
    
    @State private var offset: CGPoint = .zero
    @State private var imageSize: CGRect = .zero
    @State private var contentSize: CGRect = .zero
    
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        AsyncContentView(source: viewModel, content: content)
            .navigationTitle(viewModel.name)
            .navigationBarStyle()
    }
    
    var content: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 21) {
                spacer
                informations
                recipe
                ingredients
                source
            }
            .readScrollView(from: CoordinateSpace.main, into: $offset)
        }
        .modifier(MealViewStyle(backgroundUrl: viewModel.backgroundUrl, offset: offset.y, imageSize: $imageSize))
        .coordinateSpace(name: CoordinateSpace.main)
        .readingGeometry(from: CoordinateSpace.main, into: $contentSize)
    }
    
    private var spacer: some View {
        Spacer(minLength: imageSize.maxY - abs(contentSize.minY))
    }
    
    private var informations: some View {
        MealInformationView(viewModel: viewModel)
    }
    
    private var recipe: some View {
        VStack(alignment: .leading) {
            TitleView(viewModel.recipeTitle, style: MealViewIngredientTitleStyle())
            MultilineTextView(viewModel.recipe)
        }
    }
    
    @ViewBuilder
    private var ingredients: some View {
        if let ingredients = viewModel.ingredients {
            VStack {
//                TitleView(viewModel.ingredientsTitle, style: MealViewIngredientTitleStyle())
                ExtendedTitleView(viewModel.ingredientsTitle, titleStyle: MealViewIngredientTitleStyle(),
                                  subtitle: viewModel.ingredientsSubtitle, subtitleStyle: MealViewIngredientSubitleStyle() )
                IngredientsView(ingredients)
            }
        }
    }
    
    @ViewBuilder
    private var source: some View {
        if let source = viewModel.source {
            Link("Link", destination: source)
                .modifier(MealViewSourceStyle())
        }
    }
}

// MARK: Preview

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MocksPreview(mocks: MealViewModel.mocks,
                     type: MealViewModelMock.self) {
            MealView(viewModel: $0)
        }
    }
}
