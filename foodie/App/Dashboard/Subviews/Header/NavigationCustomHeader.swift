//
//  NavigationCustomHeader.swift
//  foodie
//
//  Created by Konrad Groschang on 08/01/2024.
//

import SwiftUI

struct NavigationCustomHeader<Content: View>: View {

    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 20) {
            content
        }
        .padding()
        .padding(.bottom, AppStyle.cornerRadius)
        .foregroundStyle(AppStyle.light)
    }

}

#Preview {
    NavigationCustomHeader { Text("Sample Text") }
}
