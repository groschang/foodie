//
//  MockedDependencyContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

actor MockedDependencyContainer: DependencyContainerType {

    static let shared = MockedDependencyContainer()

    private init() { }

    private let container = DIContainer()

    var backendClient: HTTPClient {
        get async {
            await container.resolve(HTTPClient.self)!
        }
    }
    var persistenceClient: PersistenceClient {
        get async {
            await container.resolve(PersistenceClient.self)!
        }
    }

//    var closureService: MealsClosureServiceType {
//        get async {
//            await container.resolve(MealsClosureServiceType.self)!
//        }
//    }
    var mealsService: MealsAsyncServiceType {
        get async {
            await container.resolve(MealsAsyncServiceType.self)!
        }
    }
//    var asyncStreamService: MealsAsyncStreamServiceType {
//        get async {
//            await container.resolve(MealsAsyncStreamServiceType.self)!
//        }
//    }
    var viewFactory: StreamViewFactory {
        get async {
            await container.resolve(StreamViewFactory.self)!
        }
    }
    var router: Router {
        get async {
            await container.resolve(Router.self)!
        }
    }
    var notificationService: NotificationService {
        get async {
            await container.resolve(NotificationService.self)!
        }
    }


    func assemble() async {
        await container.register(HTTPClient.self) { _ in
            APIClient()
        }

#if COREDATA
        await container.register(SwiftDataClient.self) { _ in
            do {
                return try SwiftDataClient()
            } catch {
                Log.error("Couldn't initialize Swift Data Client: \(error)")
                return SwiftDataClientLogger()
            }
        }
#else
        await container.register(PersistenceClient.self) { _ in
            CoreDataClient()
        }
#endif

//        await container.register(MealsClosureServiceType.self) { _ in
//            MealsServicePreview()
//        }

        await container.register(MealsAsyncServiceType.self) { _ in
            MealsAsyncServicePreview()
        }

//        await container.register(MealsAsyncStreamServiceType.self) { _ in
//            MealsAsyncStreamServicePreview()
//        }

//        await container.register(StreamViewFactory.self) { r in
//            await StreamViewFactory(service: await r.resolve(MealsAsyncStreamServiceType.self)!)
//        }

        await container.register(AsyncViewFactory.self) { r in
            await AsyncViewFactory(service: await r.resolve(MealsAsyncServiceType.self)!)
        }

        await container.register(Router.self) { _ in
            await Router()
        }

        await container.register(NotificationService.self) { _ in
            await NotificationService()
        }
    }
}
