//
//  AccessibilityView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

extension View {

    func accessibilityIdentifier(_ identifier: AccessibilityIdentifiable) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        accessibilityIdentifier(identifier.description)
    }
}


protocol AccessibilityIdentifiable: CustomStringConvertible {

    var rawValue: String { get }
}

extension AccessibilityIdentifiable {

    var description: String { self.rawValue }
}
