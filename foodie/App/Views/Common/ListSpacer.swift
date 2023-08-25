//
//  ListSpacer.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//

import SwiftUI

struct ListSpacer: View {
    
    let height: CGFloat
    let color: Color
    
    init(_ height: CGFloat, color: Color = .clear) {
        self.height = height
        self.color = color
    }
    
    var body: some View {
        color
            .frame(height: height)
            .listRowBackground(color)
    }
}

struct ListSpacer_Previews: PreviewProvider {
    static var previews: some View {
        ListSpacer(127, color: .red)
            .previewAsComponent()
    }
}
