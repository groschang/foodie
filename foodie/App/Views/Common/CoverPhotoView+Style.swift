//
//  CoverPhotoView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import SwiftUI

struct CoverPhotoStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .clipped()
            .scaledToFill()
            .frame(maxHeight: 600)
            .shadow(radius: 20, x: 0, y: 20)
            .padding([.top, .bottom], 30)
    }
}
