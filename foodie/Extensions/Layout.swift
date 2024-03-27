//
//  Layout.swift
//  foodie
//
//  Created by Konrad Groschang on 21/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

extension Layout {

    var isHorizontal: Bool {
        self is HStackLayout
    }

    var isVertical: Bool {
        self is VStackLayout
    }
}
