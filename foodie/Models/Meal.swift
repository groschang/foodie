//
//  Meal.swift
//  mealie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import Foundation

enum MealCodingError: Error {
    case empty
}

struct Meal: Identifiable, Codable, Hashable, Equatable {
    
    var id: String
    var name: String
    var category: String?
    var area: String?
    var recipe: String?
    var imageURL: URL?
    var youtubeURL: URL?
    var ingredients: [Ingredient]?
    var source: String?
    
    private enum MealCodingKeys: String, CodingKey {
        case meals = "meals"
    }
    
    init(id: String,
         name: String,
         category: String? = nil,
         area: String? = nil,
         recipe: String? = nil,
         imageURL: URL? = nil,
         youtubeURL: URL? = nil,
         source: String? = nil,
         ingredients: [Ingredient]? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.area = area
        self.recipe = recipe
        self.imageURL = imageURL
        self.youtubeURL = youtubeURL
        self.source = source
        self.ingredients = ingredients
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MealCodingKeys.self)
        let meals = try container.decode([MealDetail].self, forKey: .meals)
        
        guard let meal = meals.first else {
            throw MealCodingError.empty
        }
        
        self.id = meal.id
        self.name = meal.name
        self.category = meal.category
        self.area = meal.area
        self.recipe = meal.recipe
        self.imageURL = meal.imageURL
        self.youtubeURL = meal.youtubeURL
        self.source = meal.source
        self.ingredients = meal.ingredients
    }
}

extension Meal: ContainsElements {
    var isEmpty: Bool {
        id.isEmpty && name.isEmpty
    }
}

extension Meal: StringIdentifier { }

extension Meal: IdentifiableObject { }

extension Meal: Mockable {
    static let mock: Meal = loadMock(from: "meal") //TODO: change to enums
    static let mock2: Meal = loadMock(from: "meal2") //TODO: change to enums
}
