//
//  MealAsyncViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

final class MealAsyncViewModel: MealViewModelType {

    var recipeTitle: String { "Recipe".localized }
    var ingredientsTitle: String { "Ingredients".localized }
    @Published private(set) var ingredientsSubtitle: String = "0 items"
    var linkTitle: String? { "Link".localized }

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { state != .loaded }

    @Published private(set) var name: String = ""
    @Published private(set) var category: String = ""
    @Published private(set) var area: String = ""
    @Published private(set) var recipe: String = ""
    @Published private(set) var ingredients: [Ingredient]?
    @Published private(set) var source: URL?
    @Published private(set) var backgroundUrl: URL?
    @Published private(set) var youtubeUrl: URL?

    private let object: any IdentifiableObject
    private let service: MealsAsyncServiceType

    init(service: MealsAsyncServiceType, object: any IdentifiableObject) { //TODO: rename, item?
        self.service = service
        self.object = object

        if let meal = object as? Meal {
            setup(with: meal)
        } else if let mealCategory = object as? MealCategory {
            setup(with: mealCategory)
        }
    }

    @MainActor func load() async {
        guard state.isLoading == false else { return }
        state.setLoading()

         //TODO: check
        await loadMeal()
        await fetchMeal()
    }

    @MainActor private func loadMeal() async {
        if let meal = await service.loadMeal(for: category) {
            self.setup(with: meal)
            state.setLoaded()
        }
    }

    @MainActor private func fetchMeal() async {
        do {
            let meal = try await service.fetchMeal(for: object.id)
            setup(with: meal)
            state.set(for: meal)
        } catch {
            Logger.log("Fetch meal error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }

    private func setup(with mealCategory: MealCategory) {
        name = mealCategory.name
    }

    private func setup(with meal: Meal) {
        name = meal.name
        category = meal.category ?? ""
        area = meal.area ?? ""
        recipe = meal.recipe ?? ""
        ingredients = meal.ingredients
        ingredientsSubtitle = "\(ingredients?.count ?? 0) items"
        source = URL(string: meal.source ?? "") //TODO: make url in model
        backgroundUrl = meal.imageURL
        youtubeUrl = meal.youtubeURL
    }
}


#if DEBUG
extension MealAsyncViewModel {
    static let stub = MealAsyncViewModel(service: MealsAsyncServicePreview(), object: Meal.stub)
}
#endif
