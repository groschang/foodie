//
//  MealViewModelMock.swift
//  foodie
//
//  Created by Konrad Groschang on 07/02/2023.
//

import Foundation

protocol MealViewModelMockType: MealViewModelType, Mock, CustomStringConvertible { }

class MealViewModelMock: MealViewModelMockType {

    var description: String { "Mock" }

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
    @Published private(set) var youtubeUrl: URL?

    let mealCategory: MealCategory
    let service: MealsClosureServiceType

    init(category: MealCategory = .mock, service: MealsClosureServiceType = MealsServicePreview()) {
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
        youtubeUrl = meal.youtubeURL
    }
}

final class MealViewModelDeleyedMock: MealViewModelMock {

    override var description: String { "Deleyed" }

    override var mockType: MockType { .delayed }

    override init(category: MealCategory = .mock, service: MealsClosureServiceType = MealsServicePreview(delay: true)) {
        super.init(category: category, service: service)
    }
}

final class MealViewModelEmptyMock: MealViewModelMock {

    override var description: String { "Empty" }

    override var mockType: MockType { .empty }

    override func load() async {
        self.state = .empty
    }
}

final class MealViewModelLoadingMock: MealViewModelMock {

    override var description: String { "Loading" }

    override var mockType: MockType { .loading }

    override func load() async {
        state = .loading
    }
}

final class MealViewModelErrorMock: MealViewModelMock {

    override var description: String { "Error" }

    override var mockType: MockType { .error }

    override func load() async {
        state = .failed(APIError.badURL("this.is.sample.url"))
    }
}
