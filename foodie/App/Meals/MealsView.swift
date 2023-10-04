//
//  MealsView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/01/2023.
//

import SwiftUI

struct MealsView<Model>: View where Model: MealsViewModelType {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @EnvironmentObject var router: Router
    
    @StateObject var viewModel: Model

    @State private var animate = false
    @State private var offset: CGPoint = .zero

    private var layout: AnyLayout { animate ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout()) }

    init(viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        AsyncContentView(source: viewModel, content: content)
//            .navigationBarHidden(true)
            .navigationBarHiddenx() //TODO: x?
//            .navigationTitle(viewModel.categoryName)
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
        ScrollView {
            Section(
                content: { listContent },
                header: { listHeader }
            )
        }
        .coordinateSpace(name: CoordinateSpace.main)
        .modifier(MealsViewRecipesStyle())
    }

    private var listHeader: some View {
        ListHeaderView(
            title: viewModel.itemsHeader,
            action: { }
        )
        .padding()
        .readScrollView(from: CoordinateSpace.main, into: $offset)
    }
    
    private var listContent: some View {
        ForEach(viewModel.filteredItems) { meal in
            RouterLink(to: .meal(meal)) {
                MealListView(meal: meal)
            }
        }
        .modifier(ListRowModifier())
    }
}

// MARK: Previews

struct MealsView_Previews: PreviewProvider {

    static var previews: some View {
        MocksPreview(mocks: MealsViewModel.mocks, viewModelType: MealsViewModelMock.self) {
            MealsView(viewModel: $0)
        }
    }
}
