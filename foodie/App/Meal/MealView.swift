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
    
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        AsyncContentView(source: viewModel, content: content)
            .hideNavigationBar()
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
            .padding(.horizontal)
        }
        .modifier(MealViewStyle(backgroundUrl: viewModel.backgroundUrl, 
                                offset: offset.y + contentSize.minY,
                                imageSize: $imageSize))
        .coordinateSpace(name: CoordinateSpace.main)
        .readingGeometry(from: CoordinateSpace.main, into: $contentSize)
        .overlay {
            ElipseBackButton() { presentationMode.wrappedValue.dismiss() }
                .placeAtTheTop()
                .placeAtTheLeft()
                .padding()
        }
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
                ExtendedTitleView(viewModel.ingredientsTitle,
                                  style: MealViewIngredientTitleStyle(),
                                  subtitle: viewModel.ingredientsSubtitle,
                                  subtitleStyle: MealViewIngredientSubitleStyle())

                IngredientsView(ingredients)
            }
        }
    }
    
    @ViewBuilder
    private var source: some View {
        if let source = viewModel.source {
            Link("Link to the website", destination: source)
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
