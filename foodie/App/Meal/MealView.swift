//
//  MealView.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MealView<Model>: View where Model: MealViewModelType {

    enum AccessibilityKeys: String, AccessibilityIdentifiable {
        case RecipeTextView
    }

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject private var viewModel: Model

    @State private var offset: CGPoint = .zero
    @State private var imageSize: CGRect = .zero
    @State private var scrollViewSize: CGRect = .zero

    @State private var informationsOpacity: Double = .zero
    @State private var ingredientsOpacity: Double = .zero
    @State private var recipeOpacity: Double = .zero
    @State private var youtubeOpacity: Double = .zero
    @State private var sourceOpacity: Double = .zero

    init(viewModel: Model) {
        self.viewModel = viewModel
    }

    var body: some View {
        AsyncContentView(source: viewModel, content: content)
            .hideNavigationBar()
            .coordinateSpace(name: CoordinateSpace.main)
            .overlay {
                ElipseBackButton() { presentationMode.wrappedValue.dismiss() }
                    .placeAtTheTop()
                    .placeAtTheLeft()
                    .padding()
            }
    }

    var content: some View {
        OffsetObservingScrollView(offset: $offset) {
            VStack(spacing: 21) {

                spacer
                informations
                    .animateAppear($informationsOpacity, index: 1)
                ingredients
                    .animateAppear($ingredientsOpacity, index: 2)
                recipe
                    .animateAppear($recipeOpacity, index: 3)
                youtube
                    .animateAppear($youtubeOpacity, index: 4)
                source
                    .animateAppear($sourceOpacity, index: 5)

            }
            .readingGeometry(from: CoordinateSpace.main, into: $scrollViewSize)
            .padding(.horizontal)
        }
        .modifier(MealViewStyle(backgroundUrl: viewModel.backgroundUrl,
                                offset: offset.y,
                                imageSize: $imageSize))

    }

    private var spacer: some View {
        Spacer(minLength: imageSize.maxY)
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
                .accessibilityIdentifier(AccessibilityKeys.RecipeTextView)
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

#Preview {
    NavigationView {
        MealView(viewModel: MealViewModel.stub)
    }
}
