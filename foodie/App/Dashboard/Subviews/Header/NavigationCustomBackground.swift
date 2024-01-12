//
//  NavigationCustomBackground.swift
//  foodie
//
//  Created by Konrad Groschang on 08/01/2024.
//

import SwiftUI

struct NavigationCustomBackground: View {

    var color: Color

    var body: some View {

        VStack(spacing: .zero) {

            color
                .ignoresSafeArea(edges: .top)

            color
                .frame(height: AppStyle.cornerRadius)
                .defaultCornerRadius(corners: .bottom)
                .defaultShadow()
                .mask(Rectangle().padding(.bottom, -AppStyle.cornerRadius))
        }
    }
}

#Preview {
    NavigationCustomBackground(color: .white)
}
