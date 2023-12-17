//
//  EmptyStateView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//

import SwiftUI

struct EmptyStateView: View { //TODO: rename
    
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

// MARK: Previews

struct EmptyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView("Empty view")
    }
}
