//
//  ErrorView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ErrorView: View {
    
    private let description: String?
    private let action: AsyncVoidAction

    init(_ description: String? = nil, action: @escaping AsyncVoidAction) {
        self.description = description
        self.action = action
    }

    init(error: Error? = nil, action: @escaping AsyncVoidAction) {
        self.init(error?.localizedDescription, action: action)
    }
    
    var body: some View {
        VStack {
            Text("Something wrong happened")
                .modifier(TextStyle.infoScreenTitle)

            if let description {
                Text(description)
                    .modifier(TextStyle.infoScreenSubtitle)
            }
            
            Button("Try again") {
                Task { await action() }
            }
            .buttonStyle(.information)
        }
        .maxSize()
        .background { StaticGradient() }
    }
}

// MARK: Previews

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(APIError.noResponse.localizedDescription, action: { })
        ErrorView(error: nil, action: { })
    }
}
