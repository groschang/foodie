//
//  MockedDependencyContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//

import Foundation

final class MockedDependencyContainer: DependencyContainerType {

    static let shared = MockedDependencyContainer()

    private init() { }
    
    private let container = DIContainer()

    var backendClient: HTTPClient { container.resolve(HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(PersistenceClient.self)! }

    var closureService: MealsClosureServiceType { container.resolve(MealsClosureServiceType.self)! }
    var asyncService: MealsAsyncServiceType { container.resolve(MealsAsyncServiceType.self)! }
    var asyncStreamService: MealsAsyncStreamServiceType { container.resolve(MealsAsyncStreamServiceType.self)! }
    var passthroughCombineService: MealsPassthroughCombineServiceType { container.resolve(MealsPassthroughCombineServiceType.self)! }

    var router: Router { container.resolve(Router.self)! }
    var viewFactory: StreamViewFactory { container.resolve(StreamViewFactory.self)! }

    func assemble() {
        container.register(HTTPClient.self) { _ in
            APIClient()
        }

#if MOCKED || NORMAL
        container.register(PersistenceClient.self) { _ in
            CoreDataClient() //TODO: make stubs?
        }
#elseif SWIFTDATA
        container.register(SwiftDataClient.self) { _ in
            do {
                return try SwiftDataClient() //TODO: make stubs?
            } catch {
                Log.error("Couldn't initialize Swift Data Client: \(error)")
                return SwiftDataClientLogger()
            }
        }
#endif

        container.register(MealsClosureServiceType.self) { _ in
            MealsServiceMock()
        }

        container.register(MealsAsyncServiceType.self) { _ in
            MealsAsyncServiceMock()
        }

        container.register(MealsAsyncStreamServiceType.self) { _ in
            MealsAsyncStreamServiceMock()
        }

        container.register(MealsPassthroughCombineServiceType.self) { [unowned self] _ in
            MealsPassthroughCombineService(backendClient: backendClient, 
                                           persistanceClient: persistenceClient) //TODO: make stubs?
        }

        container.register(StreamViewFactory.self) { [unowned self] _ in
            StreamViewFactory(service: asyncStreamService) //TODO: make stubs?
        }


        container.register(Router.self) { _ in
            Router() //TODO: make stubs?
        }
    }
}
