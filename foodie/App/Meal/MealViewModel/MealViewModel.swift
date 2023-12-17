//
//  MealViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import Foundation

protocol MealLocalizable {
    var recipeTitle: String { get }
    var ingredientsTitle: String { get }
    var ingredientsSubtitle: String { get }
    var linkTitle: String? { get }
}

protocol MealInformations: ObservableObject {
    var name: String { get }
    var category: String { get }
    var area: String { get }
    var recipe: String { get }
    var ingredients: [Ingredient]? { get }
    var source: URL? { get }
    var backgroundUrl: URL? { get }
}

protocol MealViewModelType: MealLocalizable, MealInformations, LoadableObject { }

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
    @Published private(set) var backgroundUrl: URL?
    
    private let mealCategory: MealCategory
    private let service: MealsClosureServiceType
    
    init(service: MealsClosureServiceType, mealCategory: any IdentifiableObject) {
        self.service = service
        self.mealCategory = mealCategory as! MealCategory

        setup()
    }

    private func setup() {
        name = mealCategory.name
    }

    @MainActor func load() async {
        await fetchMeal()
    }
    
    @MainActor private func fetchMeal() async {
        guard state.isLoading == false else { return }
        
        do {
            try await getMeal()
        } catch {
            Logger.log("Fetch meal error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }
    
    @MainActor private func getMeal() async throws {
        state = .loading
        
        let meal = try await service.getMeal(for: mealCategory.id) {
            [unowned self] meal in
            
            if meal.isEmpty == false {
                self.state = .loaded
                self.setup(with: meal)
            }
        }
        
        setup(with: meal)
        state = meal.isEmpty ? .empty : .loaded
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
    }
}
