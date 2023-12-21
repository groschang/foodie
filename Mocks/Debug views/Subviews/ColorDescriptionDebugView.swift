//
//  ColorDescriptionDebugView.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//

import SwiftUI

struct ColorDescriptionDebugView: View {
    
    let color: Color
    
    var body: some View {
        Text(color.description.uppercased())
            .scalableStyle()
            .padding(.vertical)
            .frame(height: 55)
            .maxWidth()
            .background(color)
    }
}
