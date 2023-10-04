//
//  Router.swift
//  foodie
//
//  Created by Konrad Groschang on 03/10/2023.
//

import SwiftUI

final class Router: ObservableObject {

    public enum Destination: Codable, Hashable {
        case categories
        case emptyCategories
        case meals(Category)
        case emptyMeals
        case meal(MealCategory)
    }

    @Published var navigationPath = NavigationPath()

    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }

    func navigateBack() {
        navigationPath.removeLast()
    }

    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
