//
//  NotificationManager.swift
//  foodie
//
//  Created by Konrad Groschang on 24/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import UIKit
import Combine

protocol NotificationManagerProtocol: Sendable {
    static var shared: NotificationManager { get }
    var notificationPublisher: AnyPublisher<UNNotificationContent, Never> { get }
    var statusPublisher: AnyPublisher<UNAuthorizationStatus, Never> { get }

    func requestPermission() async throws
    func refreshStatus() async
}


final class NotificationManager: NotificationManagerProtocol, @unchecked Sendable {

    static let shared = NotificationManager()

    var notificationPublisher: AnyPublisher<UNNotificationContent, Never> {
        notificationHandler.notification
    }

    var statusPublisher: AnyPublisher<UNAuthorizationStatus, Never> {
        authorizationHandler.status
    }
    
    private let notificationCenter: UNUserNotificationCenter
    private let notificationHandler: NotificationHandler
    private let authorizationHandler: NotificationStatus

    private init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
        self.notificationHandler = NotificationHandler(notificationCenter: notificationCenter)
        self.authorizationHandler = NotificationStatus(notificationCenter: notificationCenter)

        self.notificationCenter.delegate = self.notificationHandler

        Task {
            await authorizationHandler.refreshStatus()
        }
    }

    func requestPermission() async throws {
        let status = await authorizationHandler.authorizationStatus()

        if status == .denied {
            throw NotificationHandlerError.accessDenied
        }

        if status != .authorized {
            _ = try await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
            await authorizationHandler.refreshStatus()
        }
    }

    func refreshStatus() async {
        await authorizationHandler.refreshStatus()
    }
}
