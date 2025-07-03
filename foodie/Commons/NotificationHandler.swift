//
//  NotificationHandler.swift
//  foodie
//
//  Created by Konrad Groschang on 24/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import UIKit
import Combine


enum NotificationHandlerError: Error {
    case accessDenied
}


class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {

    var notification: AnyPublisher<UNNotificationContent, Never> {
        contentSubject.eraseToAnyPublisher()
    }

    private let contentSubject = PassthroughSubject<UNNotificationContent, Never>()

    private let notificationCenter: UNUserNotificationCenter

    init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
    }

    /** Handle notification when app is in background */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        NotificationCenter.default.post(name: Notification.Name.foodie , object: response.notification.request.content)
        contentSubject.send(response.notification.request.content)
        completionHandler()
    }

    /** Handle notification when the app is in foreground */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        NotificationCenter.default.post(name: Notification.Name.foodie, object: notification.request.content)
        contentSubject.send(notification.request.content)
        completionHandler(.sound)
    }
}

extension NotificationHandler {

    static func openSettings() {
        DispatchQueue.main.async {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                      options: [:],
                                      completionHandler: nil)
        }
    }
}




extension Notification.Name {
    static let foodie = Notification.Name("com.conrad.foodie.notification")
}

extension UNAuthorizationStatus: @retroactive CustomStringConvertible {

    public var description: String {
        switch self {
        case .notDetermined:    return "Not determined"
        case .denied:           return "Denied"
        case .authorized:       return "Authorized"
        case .provisional:      return "Provisional"
        case .ephemeral:        return "Ephemeral"
        @unknown default:
            return "Unknown"
        }
    }
}
