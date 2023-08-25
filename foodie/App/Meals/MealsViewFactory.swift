//
//  MealsViewFactory.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import SwiftUI

struct MealsViewFactory {
    
    private(set) var service: MealsServiceType
    
    init(service: MealsServiceType) {
        self.service = service
    }
    
    @MainActor
    func makeMealView(selection: MealCategory) -> some View {
        Logger.log(selection.name, onLevel: .info)
        let viewModel = MealViewModel(service: service, mealCaterory: selection)
        return MealView(viewModel: viewModel)
    }
}


extension MealsViewFactory {
    static let mock = MealsViewFactory(service: MealsServiceMock())
}
