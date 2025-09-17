//
//  ElipseBackButton+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 9/17/25.
//

import SwiftUI

struct ElipseBackButtonGlassyStyle: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content.buttonStyle(.glass)
        } else {
            content
        }
    }
}
