//
//  ColorDebugView.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//

import SwiftUI

struct ColorDebugView: View {
    
    let color: Color

    init(_ color: Color) {
        self.color = color
    }

    init(color: Color) {
        self.color = color
    }

    var body: some View {
        
        VStack(alignment: .center) {
            
            ColorDescriptionDebugView(color: color)
                .leafShaped()
            
            RGBDebugView(color: color, layout: HStackLayout())
        }
    }
}
