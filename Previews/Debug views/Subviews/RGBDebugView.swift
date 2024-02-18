//
//  RGBDebugView.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//

import SwiftUI

struct RGBDebugView: View {
    
    let color: Color
    
    let layout: any Layout
    
    init(color: Color, layout: any Layout = VStackLayout()) {
        self.color = color
        self.layout = layout
    }
    
    var body: some View {
        
        let components = color.components
        
        AnyLayout(layout) {
            
            Text("R: \(components.red)")
                .scalableStyle()
            
            Text("G: \(components.green)")
                .scalableStyle()
            
            Text("B: \(components.blue)")
                .scalableStyle()
            
            if layout.isVertical {
                Text("Opacity: \(components.opacity, format: .percent)")
                    .scalableStyle()
            }
        }
        .maxWidth()
        .padding(layout.isVertical ? .vertical : [])
        .overlay {
            if layout.isVertical {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 2)
            } else {
                EmptyView()
            }
        }
        
        if layout.isHorizontal {
            Text("Opacity: \(components.opacity, format: .percent)")
                .scalableStyle()
        }
    }
}
