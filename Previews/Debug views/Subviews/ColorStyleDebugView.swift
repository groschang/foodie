//
//  ColorStyleDebugView.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//

import SwiftUI

struct ColorStyleDebugView: View {
    
    let style: ColorStyle

    init(_ style: ColorStyle) {
        self.style = style
    }

    init(style: ColorStyle) {
        self.style = style
    }

    var body: some View {
        
        if style.lightColor == style.darkColor {
            
            ColorDebugView(color: style.lightColor)
            
        } else {
            
            VStack(alignment: .center) {
                
                HStack(spacing: 0) {
                    
                    ColorDescriptionDebugView(color: style.lightColor)
                    
                    ColorDescriptionDebugView(color: style.darkColor)
                }
                .leafShaped()
                
                HStack {
                    
                    RGBDebugView(color: style.lightColor, layout: VStackLayout())
                        .maxWidth()

                    RGBDebugView(color: style.darkColor, layout: VStackLayout())
                        .maxWidth()
                }
            }
        }
    }
}
