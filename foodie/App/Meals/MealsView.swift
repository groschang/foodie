//
//  MealsView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MealsView<Model>: View where Model: MealsViewModelType {

    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel: Model

    @State private var animate = false
    @State private var offset: CGPoint = .zero

    @State private var listType: ListType = .grid

    init(viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        AsyncContentView(source: viewModel, content: content)
            .hideNavigationBar()
    }

    private var content: some View {
        VStack {
            header
            recipes
        }
        .background(AppStyle.background)
        .animation(.spring(), value: animate)
        .onChange(of: offset) { offset in
            animate = offset.y > 100
        }
    }

    private var header: some View {
        AnimatedListHeader(
            title: viewModel.categoryName,
            imageUrl: viewModel.backgroundUrl,
            animate: $animate,
            dismissAction: { dismiss() }
        )
        .modifier(MealsViewHeaderStyle())
    }

    private var recipes: some View {
        OffsetObservingScrollView(offset: $offset) {
            Section(
                content: { recipesContent },
                header: { recipesHeader }
            )
        }
        .modifier(MealsViewRecipesStyle())
    }

    private var recipesHeader: some View {
        ListHeaderView(
            title: viewModel.itemsHeader,
            filterAction: { },
            modeAction: {
                withAnimation {
                    listType = listType.next()
                }
            },
            listType: $listType
        )
        .padding()
    }

    @ViewBuilder
    private var recipesContent: some View {

        let items = viewModel.filteredItems

        switch listType {
        case .list:
            MealsList(items: items)
        case .post:
            MealsPosts(items: items)
        case .grid:
            MealsGrid(items: items)
        }
    }
}


// MARK: Previews

#Preview {
    MealsView(viewModel: MealsAsyncStreamViewModel.stub)
}
