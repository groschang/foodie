//
//  MealsView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/01/2023.
//

import SwiftUI

struct MealsView<Model>: View where Model: MealsViewModelType {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
        .animation(.spring(), value: animate)
        .onChange(of: offset) { offset in
            animate = offset.y > 50
        }
    }

    private var header: some View {
        ListHeader(
            title: viewModel.categoryName,
            imageUrl: viewModel.backgroundUrl,
            animate: $animate,
            backButtonAction: { presentationMode.wrappedValue.dismiss() }
        )
        .modifier(MealsViewHeaderStyle())
    }

    private var recipes: some View {
        List {
            Section(
                content: { scrollViewContent },
                header: { listHeader }
            )
        }
        .coordinateSpace(name: CoordinateSpace.main)
        .modifier(MealsViewRecipesStyle())
    }

    private var listHeader: some View {
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
        .readScrollView(from: CoordinateSpace.main, into: $offset)
    }

    @ViewBuilder
    private var scrollViewContent: some View {
        if listType == .grid {
            gridContent
        } else {
            listContent
        }
    }


    private var listContent: some View {

        ForEach(viewModel.filteredItems) { meal in

            RouterLink(to: .meal(meal)) {

                if listType == .list {

                    MealListView(meal: meal)

                } else if listType == .post {

                    MealGridView(meal: meal)

                }
            }
        }
        .modifier(ListRowModifier())
    }


    private var gridContent: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 140))],
            spacing: 20
        ) {
            ForEach(viewModel.filteredItems) { meal in

                RouterLink(to: .meal(meal), style: .growing) {
                    MealGridView(
                        meal: meal,
                        fontType: .small
                    )
                }
            }
        }
    }
}

// MARK: Previews

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MocksPreview(mocks: MealsViewModel.mocks,
                     type: MealsViewModelMock.self) {
            MealsView(viewModel: $0)
        }
    }
}
