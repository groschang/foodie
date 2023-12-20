//
//  PhotoPlaceholderView.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//

import SwiftUI

struct PhotoPlaceholderView: View {

    var body: some View {
        Image(systemName: "fork.knife.circle")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    PhotoPlaceholderView()
}
