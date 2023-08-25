//
//  DashboardViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 10/07/2023.
//

import SwiftUI

protocol DashboardViewFactoryType {
    associatedtype V: View
    associatedtype T: View
    
    func makeMealsView(_ category: Category) -> V
    func makeDefaultView() -> T
}

class DashboardViewFactory: DashboardViewFactoryType {

    private var service: MealsServiceType
    lazy private var mealsViewFactory = MealsViewFactory(service: service)

    init(service: MealsServiceType) {
        self.service = service
    }

    @MainActor
    func makeMealsView(_ category: Category) -> some View {
        //        Logger.log(category.name)
        //        Log.warning(service)
        //        Log.warning(mealsViewFactory)

        //        let viewModel = MealsViewModel(service: service, category: category)

//                let viewModel = MealsViewModel.mock
        let viewModel = MealsAsyncViewModel(service: MealsServiceVMock(), category: category)
//        let viewModel = MealsViewModelMock()
        //        let viewModel = MealsViewModel(service: MealsServiceMock(), category: .mock)
//        let viewFactory = MealsViewFactory.mock
        let viewFactory = MealsViewFactory(service: service)

        let view = MealsView(viewModel: viewModel, viewFactory: viewFactory)

//        return view
        return Color.red
    }

    @MainActor
    func makeDefaultView() -> some View {
        InformationView(message: "Select category")
            .ignoresSafeArea()
    }
}


extension DashboardViewFactory {
    static let mock = DashboardViewFactory(service: MealsServiceMock())
}
