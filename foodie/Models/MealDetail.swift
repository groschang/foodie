//
//  MealDetail.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

struct MealDetail: Identifiable, Codable, Hashable, Equatable {
    
    var id: String
    var name: String
    var category: String?
    var area: String?
    var recipe: String?
    var imageURL: URL?
    var youtubeURL: URL?
    var source: String?
    var ingredients: [Ingredient]?
    
    private enum CustomCodingKeys: String, CodingKey, CaseIterable {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case recipe = "strInstructions"
        case imageURL = "strMealThumb"
        case youtubeURL = "strYoutube"
        case source = "strSource"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
        self.id = try container.decode(String.self, forKey:  .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.area = try container.decodeIfPresent(String.self, forKey: .area)
        self.recipe = try container.decodeIfPresent(String.self, forKey: .recipe)
        self.imageURL = try? container.decodeIfPresent(URL.self, forKey: .imageURL)
        self.youtubeURL = try? container.decodeIfPresent(URL.self, forKey: .youtubeURL)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        
        let ingredients = try CustomCodingKeys.array(from: .ingredient1, to: .ingredient20).map {
            try container.decodeIfPresent(String.self, forKey: $0) ?? ""
        }
        let measures = try CustomCodingKeys.array(from: .measure1, to: .measure20)
            .map { try container.decodeIfPresent(String.self, forKey: $0) ?? "" }
        
        self.ingredients = zip(ingredients, measures)
            .filter { $0.0.trimmingCharacters(in: .whitespaces).isNotEmpty }
            .map(Ingredient.init)
            .sorted()
    }
}

extension MealDetail: Stubable {
    static let stub: MealDetail = loadStub(from: "meal")
}
