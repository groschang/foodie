//
//  EmptyStateView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct EmptyStateView: View {
    
    private let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    var body: some View {
        Text(message)
            .modifier(TextStyle.infoScreenTitle)
            .maxSize()
            .staticGradient()
    }
}

// MARK: - Previews

#Preview {
    EmptyStateView("Empty view")
}
