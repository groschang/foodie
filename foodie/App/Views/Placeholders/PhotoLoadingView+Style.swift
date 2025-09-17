//
//  PhotoLoadingView+Style.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct PhotoLoadingViewStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .tint(AppStyle.darkGray)
    }
}
