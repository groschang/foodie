//
//  Router.swift
//  foodie
//
//  Created by Konrad Groschang on 03/10/2023.
//

import SwiftUI

enum Route: Codable, Hashable {
    case categories
    case emptyCategories
    case meals(any IdentifiableObject) //TODO: Check Category
    case emptyMeals
    case meal(any IdentifiableObject) //TODO: Check MealCategory
}

extension Route {
    enum Raw {
        static let categories = "categories"
        static let emptyCategories = "emptyCategories"
        static let meals = "meals"
        static let emptyMeals = "emptyMeals"
        static let meal = "meal"
    }
}


extension Route: RawRepresentable {

    var rawValue: String {
        switch self {
        case .categories:
            return Route.Raw.categories

        case .emptyCategories:
            return Route.Raw.emptyCategories
            
        case .meals(_):
            return Route.Raw.meals

        case .emptyMeals:
            return Route.Raw.emptyMeals

        case .meal(_):
            return Route.Raw.meal
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case Route.Raw.categories:
            self = .categories

        case Route.Raw.emptyCategories:
            self = .emptyCategories

        case _ where rawValue.contains(Route.Raw.meals):
            guard let id = Route.id(from: rawValue) else { return nil }
            let category = ObjectId(id)
            self = .meals(category)

        case Route.Raw.emptyMeals:
            self = .emptyMeals

        case _ where rawValue.contains(Route.Raw.meal):
            guard let id = Route.id(from: rawValue) else { return nil }
            let mealCategory = ObjectId(id)
            self = .meal(mealCategory)

        default:
            return nil
        }
    }

    private static func id(from value: String) -> String? {
        let components = value.components(separatedBy: "/")
        return components.last
    }
}

extension Route {
    init?(url: URL) {
        guard let route = Route(rawValue: url.absoluteString) else { return nil }
        Log.log(route, onLevel: .verbose)
        self = route
    }
}

final class Router: ObservableObject {

    @Published var navigationPath = NavigationPath()

    func navigate(to route: Route) {
        navigationPath.append(route)
    }

    func navigateBack() {
        navigationPath.removeLast()
    }

    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}

