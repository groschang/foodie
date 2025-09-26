//
//  DependencyContainerType.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

protocol DependencyContainerType {

    associatedtype ViewFactoryAssociatedType: ViewFactoryType

    static var shared: Self { get }

    var backendClient: HTTPClient { get async }
    var persistenceClient: PersistenceClient { get async }

    var mealsService: MealsAsyncServiceType { get async }
    var router: Router { get async }
    var viewFactory: ViewFactoryAssociatedType { get async }

    func assemble() async
}
