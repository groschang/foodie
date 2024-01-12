//
//  DependencyContainerType.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2024.
//

import Foundation

protocol DependencyContainerType {

    associatedtype ViewFactoryAssociatedType: ViewFactoryType

    static var shared: Self { get }

    var backendClient: HTTPClient { get }
    var persistenceClient: PersistenceClient { get }

    var closureService: MealsClosureServiceType { get }
    var asyncService: MealsAsyncServiceType { get }
    var asyncStreamService: MealsAsyncStreamServiceType { get }
    var passthroughCombineService: MealsPassthroughCombineServiceType { get }

    var router: Router { get }
    var viewFactory: ViewFactoryAssociatedType { get }

    func assemble()
}
