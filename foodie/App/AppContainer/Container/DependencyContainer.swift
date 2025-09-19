//
//  DependencyContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 09/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

/// User can choose between Directives in the precompile process, it's also possible to swift realtime inferfaces,
/// i.e. SWIFTDATA, DEBUG or  REALM precompiler options
/// SWIFTDATA requires iOS version 17 therefore new target was created

actor DependencyContainer: DependencyContainerType {    

    static let shared = DependencyContainer()

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
    var viewFactory: AsyncViewFactory {
        get async {
            await container.resolve(AsyncViewFactory.self)!
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
        await container.register(PersistenceClient.self) { _ in
            CoreDataClient()
        }
#elseif REALM
        await container.register(PersistenceClient.self) { _ in
            RealmClient()
        }
#else 
        await container.register(PersistenceClient.self) { _ in
            do {
                return try SwiftDataClient()
            } catch {
                Log.error("Couldn't initialize Swift Data Client: \(error)")
                return SwiftDataClientLogger()
            }
        }
#endif

//        await container.register(MealsClosureServiceType.self) { r in
//            MealsClosureService(
//                backendClient: await r.resolve(HTTPClient.self)!,
//                persistanceClient: await r.resolve(PersistenceClient.self)!
//            )
//        }

        await container.register(MealsAsyncServiceType.self) { r in
            MealsAsyncService(
                backendClient: await r.resolve(HTTPClient.self)!,
                persistanceClient: await r.resolve(PersistenceClient.self)!
            )
        }

//        await container.register(MealsAsyncStreamServiceType.self) { r in
//            MealsAsyncStreamService(
//                backendClient: await r.resolve(HTTPClient.self)!,
//                persistanceClient: await r.resolve(PersistenceClient.self)!
//            )
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
