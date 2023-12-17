//
//  MockedDependencyContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//

import Foundation

struct MockedDependencyContainer: DependencyContainerType {

    let container = DIContainer()

    static let shared = MockedDependencyContainer()

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
            CoreDataClient() //TODO: make mock?
        }

        container.register(type: MealsClosureServiceType.self) { _ in
            MealsServiceMock()
        }

        container.register(type: MealsAsyncServiceType.self) { _ in
            MealsServiceAsyncMock()
        }

        container.register(type: MealsAsyncStreamServiceType.self) { _ in
            MealsAsyncStreamService(backendClient: backendClient, persistanceClient: persistenceClient) //TODO: make mock?
        }

        container.register(type: MealsPassthroughCombineServiceType.self) { _ in
            MealsPassthroughCombineService(backendClient: backendClient, persistanceClient: persistenceClient) //TODO: make mock?
        }

        container.register(type: Router.self) { _ in
            Router() //TODO: make mock?
        }

        container.register(type: StreamViewFactory.self) { _ in
            StreamViewFactory(service: asyncStreamService) //TODO: make mock?
        }
    }
}
