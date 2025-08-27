//
//  BackButton.swift
//  foodie
//
//  Created by Konrad Groschang on 15/04/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct BackButton: View {

    let action: VoidAction?

    @State var tint: ColorStyle = AppStyle.accent

    var body: some View {
        Button(action: { action?() }) {
            Image(systemName: "arrow.backward")
                .imageScale(.large)
                .background(.clear)
                .foregroundStyle(tint)

        }
    }
}


extension BackButton {

    func tint(_ color: ColorStyle) -> some View {
        BackButton(action: self.action, tint: color)
    }

    func tint(_ color: Color) -> some View {
        BackButton(action: self.action, tint: ColorStyle(color))
    }
    
}
