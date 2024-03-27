//
//  ColorDescriptionDebugView.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ColorDescriptionDebugView: View {
    
    let color: Color

    var description: String {
        if color.description.count > 21 {
            return color.hex
        } else {
            return color.description.uppercased()
        }
    }

    var body: some View {
        Text(description)
            .bold()
            .scalableStyle()
            .padding(.vertical)
            .frame(height: 55)
            .maxWidth()
            .foregroundStyle(
                color.isBright ? Color.black : Color.white
            )
            .background(color)
    }
}
