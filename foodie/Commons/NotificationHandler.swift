//
//  NotificationHandler.swift
//  foodie
//
//  Created by Konrad Groschang on 24/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

@preconcurrency import UIKit
import Combine


enum NotificationHandlerError: Error, Sendable {
    case accessDenied
}


final class NotificationHandler: NSObject, UNUserNotificationCenterDelegate, @unchecked Sendable {
    
    var notification: AnyPublisher<UNNotificationContent, Never> {
        contentSubject.eraseToAnyPublisher()
    }
    
    private let contentSubject = PassthroughSubject<UNNotificationContent, Never>()
    private let notificationCenter: UNUserNotificationCenter
    
    init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
        super.init()
    }
    
    // Handle notification when app is in background
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping @Sendable () -> Void
    ) {
        let content = response.notification.request.content
        
        Task { @MainActor in
            NotificationCenter.default.post(name: Notification.Name.foodie, object: content)
        }
        
        contentSubject.send(content)
        completionHandler()
    }
    
    // Handle notification when the app is in foreground
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping @Sendable (UNNotificationPresentationOptions) -> Void
    ) {
        let content = notification.request.content
        
        Task { @MainActor in
            NotificationCenter.default.post(name: Notification.Name.foodie, object: content)
        }
        
        contentSubject.send(content)
        completionHandler([.sound, .banner])
    }
}


extension NotificationHandler {
    
    @MainActor
    static func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsUrl)
    }
}


extension Notification.Name {
    static let foodie = Notification.Name("com.conrad.foodie.notification")
}


extension UNAuthorizationStatus: @retroactive CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .notDetermined: return "Not determined"
        case .denied: return "Denied"
        case .authorized: return "Authorized"
        case .provisional: return "Provisional"
        case .ephemeral: return "Ephemeral"
        @unknown default: return "Unknown"
        }
    }
}
