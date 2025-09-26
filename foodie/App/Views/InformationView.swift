//
//  InformationView.swift
//  foodie
//
//  Created by Konrad Groschang on 05/02/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct InformationView: View {
    
    private let message: String

    init(_ message: String) {
        self.message = message
    }
    
    var body: some View {
        Text(message)
            .modifier(TextStyle.infoScreenTitle)
            .maxSize()
            .animatedGradient()
    }
}

// MARK: - Previews

#Preview {
    InformationView("Sample text")
}
