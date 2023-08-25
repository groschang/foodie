//
//  InformationView.swift
//  foodie
//
//  Created by Konrad Groschang on 05/02/2023.
//

import SwiftUI

struct InformationView: View {
    
    let message: String
    
    var body: some View {
        Text(message)
            .title()
            .foregroundColor(ColorStyle.black.lightOpacity())
            .maxSize()
            .background { AnimatedGradient() }
    }
}

// MARK: Previews

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(message: "Sample text")
    }
}
