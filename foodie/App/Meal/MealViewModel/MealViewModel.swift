//
//  MealViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

@MainActor
protocol MealLocalizable {
    var recipeTitle: String { get }
    var ingredientsTitle: String { get }
    var ingredientsSubtitle: String { get }
    var linkTitle: String? { get }
}


@MainActor
protocol MealInformations: ObservableObject {
    var name: String { get }
    var category: String { get }
    var area: String { get }
    var recipe: String { get }
    var ingredients: [Ingredient]? { get }
    var source: URL? { get }
    var youtubeUrl: URL? { get }
    var backgroundUrl: URL? { get }
}


@MainActor
protocol MealViewModelType: MealLocalizable,
                            MealInformations,
                            LoadableObject { }


final class MealViewModel: MealViewModelType {

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
    @Published private(set) var youtubeUrl: URL?
    @Published private(set) var backgroundUrl: URL?

    private let object: any IdentifiableObject
    private let service: MealsClosureServiceType

    init(service: MealsClosureServiceType, object: any IdentifiableObject) {
        self.service = service
        self.object = object

        if let meal = object as? Meal {
            setup(with: meal)
        } else if let mealCategory = object as? MealCategory {
            setup(with: mealCategory)
        }
    }

    func load() async {
        await fetchMeal()
    }

    private func fetchMeal() async {
        guard state.isLoading == false else { return }

        do {
            try await getMeal()
        } catch {
            Logger.log("Fetch meal error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }
    private func getMeal() async throws {
        state = .loading

        let meal = try await service.getMeal(for: object.id) { [unowned self] meal in
            Task { @MainActor in
                if !meal.isEmpty {
                    self.state = .loaded
                    self.setup(with: meal)
                }
            }
        }

        setup(with: meal)
        state.set(for: meal)
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
        source = URL(string: meal.source ?? "") 
        backgroundUrl = meal.imageURL
        youtubeUrl = meal.youtubeURL
    }
}

//MARK: - Mock

#if DEBUG
extension MealViewModel {
    @MainActor static let stub = MealViewModel(service: MealsServicePreview(), object: Meal.stub)
}
#endif
