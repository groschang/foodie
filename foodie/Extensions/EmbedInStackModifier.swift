//
//  EmbedInStackModifier.swift
//  foodie
//
//  Created by Konrad Groschang on 25/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct EmbedInStackModifier: ViewModifier {

    @Environment(\.sizeCategory) var sizeCategory

    func body(content: Content) -> some View {
        Group {
            if sizeCategory > ContentSizeCategory.medium {
                VStack { content }
            } else {
                HStack { content }
            }
        }
    }
}


extension Group where Content: View {

    @MainActor
    func embedInStack() -> some View {
        modifier(EmbedInStackModifier())
    }
    
}
