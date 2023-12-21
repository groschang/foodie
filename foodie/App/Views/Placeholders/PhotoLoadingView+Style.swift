//
//  PhotoLoadingView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import SwiftUI

struct PhotoLoadingViewStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: 87, height: 87)
            .background {
                Color.white
                    .cornerRadius(6)
                    .shadow(color: .black.heavyOpacity(), radius: 5)
                    .transition(.slide)
                    .lightOpacity()
            }
    }
}
