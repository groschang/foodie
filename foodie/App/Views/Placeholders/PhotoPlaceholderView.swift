//
//  PhotoPlaceholderView.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct PhotoPlaceholderView: View {

    var body: some View {
        Image(systemName: "fork.knife.circle")
            .resizable()
            .foregroundStyle(Color.shadow)
            .imageScale(.large)
            .scaledToFit()
    }
}

// MARK: - Preview

#Preview {
    PhotoPlaceholderView()
}
