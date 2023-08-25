//
//  CategoriesViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import SwiftUI

protocol CategoriesViewFactoryType {
    associatedtype V: View
    associatedtype T: View
    func makeMealsView(_ category: Category) -> V where V: View
    func makeDefaultView() -> T
}

class CategoriesViewFactory: CategoriesViewFactoryType {
    
    private(set) var service: MealsServiceType
    lazy private(set) var mealsViewFactory = MealsViewFactory(service: service)
    
    init(service: MealsServiceType) {
        self.service = service
    }
    
    @MainActor
    func makeMealsView(_ category: Category) -> some View {
        Logger.log(category.name)
        let viewModel = MealsViewModel(service: service, category: category)
        return NavigationStack {
            MealsView(viewModel: viewModel, viewFactory: mealsViewFactory)

        }
    }
    
    func makeDefaultView() -> some View {
        InformationView(message: "Select category")
            .ignoresSafeArea()
    }
}


extension CategoriesViewFactory {
    static let mock = CategoriesViewFactory(service: MealsServiceMock())
}
