//
//  InformationView.swift
//  foodie
//
//  Created by Konrad Groschang on 05/02/2023.
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

// MARK: Previews

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView("Sample text")
    }
}
