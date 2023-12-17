//
//  DependencyContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 09/05/2023.
//

import Foundation

protocol DependencyContainerType {

    associatedtype ViewFactoryAssociatedType: ViewFactoryType

    var container: DIContainer { get }

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

struct DependencyContainer: DependencyContainerType {

    let container = DIContainer()

    static let shared = DependencyContainer()

    private init() { }

    var backendClient: HTTPClient { container.resolve(type: HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(type: PersistenceClient.self)! }

    var closureService: MealsClosureServiceType { container.resolve(type: MealsClosureServiceType.self)! }
    var asyncService: MealsAsyncServiceType { container.resolve(type: MealsAsyncServiceType.self)! }
    var asyncStreamService: MealsAsyncStreamServiceType { container.resolve(type: MealsAsyncStreamServiceType.self)! }
    var passthroughCombineService: MealsPassthroughCombineServiceType { container.resolve(type: MealsPassthroughCombineServiceType.self)! }

    var router: Router { container.resolve(type: Router.self)! }
    var viewFactory: StreamViewFactory { container.resolve(type: StreamViewFactory.self)! }

    func assemble() {
        container.register(type: HTTPClient.self) { _ in
            APIClient()
        }

        container.register(type: PersistenceClient.self) { _ in
            CoreDataClient()
        }

        container.register(type: MealsClosureServiceType.self) { _ in
            MealsClosureService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsAsyncServiceType.self) { _ in
            MealsAsyncService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsAsyncStreamServiceType.self) { _ in
            MealsAsyncStreamService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsPassthroughCombineServiceType.self) { _ in
            MealsPassthroughCombineService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: Router.self) { _ in
            Router()
        }

        container.register(type: StreamViewFactory.self) { _ in
            StreamViewFactory(service: asyncStreamService)
        }
    }
}
