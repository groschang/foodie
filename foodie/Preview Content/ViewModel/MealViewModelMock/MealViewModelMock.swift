//
//  MealViewModelMock.swift
//  foodie
//
//  Created by Konrad Groschang on 07/02/2023.
//

import Foundation

protocol MealViewModelMockType: MealViewModelType, Mock { }

class MealViewModelMock: MealViewModelMockType {

    var mockType: MockType { .normal }

    var recipeTitle: String { "Recipe".localized }
    var ingredientsTitle: String { "Ingredients".localized }
    @Published private(set) var ingredientsSubtitle: String = "0 items"
    var linkTitle: String? { "Link".localized } //TODO: change

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { state != .loaded }

    @Published var name: String = ""
    @Published var category: String = ""
    @Published var area: String = ""
    @Published var recipe: String = ""
    @Published var ingredients: [Ingredient]?
    @Published var source: URL?
    @Published var backgroundUrl: URL?

    let mealCategory: MealCategory
    let service: MealsServiceType

    init(category: MealCategory = .mock, service: MealsServiceType = MealsServiceMock()) {
        self.mealCategory = category
        self.service = service

        setup(with: mealCategory)
    }

    @MainActor func load() async {
        guard let meal = try? await service.getMeal(for: mealCategory.id, handler: nil) else { return }

        setup(meal: meal)
        self.state = .loaded
    }

    private func setup(with mealCaterory: MealCategory) {
        name = mealCaterory.name
    }

    private func setup(meal: Meal) {
        name = meal.name
        category = meal.category ?? ""
        area = meal.area ?? ""
        recipe = meal.recipe ?? ""
        ingredients = meal.ingredients
        ingredientsSubtitle = "\(ingredients?.count ?? 0) items"
        source = URL(string: meal.source ?? "") //TODO:
        backgroundUrl = meal.imageURL
    }
}

final class MealViewModelDeleyedMock: MealViewModelMock {

    override var mockType: MockType { .delayed }

    override init(category: MealCategory = .mock, service: MealsServiceType = MealsServiceMock(delay: true)) {
        super.init(category: category, service: service)
    }
}

final class MealViewModelEmptyMock: MealViewModelMock {

    override var mockType: MockType { .empty }

    override func load() async {
        self.state = .empty
    }
}

final class MealViewModelLoadingMock: MealViewModelMock {

    override var mockType: MockType { .loading }

    override func load() async {
        state = .loading
    }
}

final class MealViewModelErrorMock: MealViewModelMock {

    override var mockType: MockType { .error }

    override func load() async {
        state = .failed(APIError.badURL("this.is.sample.url"))
    }
}
