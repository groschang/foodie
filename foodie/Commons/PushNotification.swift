//
//  PushNotification.swift
//  foodie
//
//  Created by Konrad Groschang on 27/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import UIKit

struct PushNotification {

    let title: String?
    let subtitle: String?
    let body: String?

    init(title: String? = nil, subtitle: String? = nil, body: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.body = body
    }

    init(_ content: UNNotificationContent) {
        self.title = content.title.nilIfEmpty()
        self.subtitle = content.subtitle
        self.body = content.body.nilIfEmpty()
    }
}

extension PushNotification: Identifiable {
    var id: String { UUID().uuidString }
}

extension PushNotification: Equatable { }

extension PushNotification {
    static let stub = PushNotification(title: "Title", subtitle: "Subtitle", body: "Body")
}

extension PushNotification {
    static func random() -> PushNotification {
        let number = Int.random(in: 1...100)
        return PushNotification(title: "Title \(number)",
                                subtitle: "Subtitle \(number)",
                                body: "Body \(number)")
    }
}

extension PushNotification {
    static let empty = PushNotification()
}
