//
//  EdgeInsets.swift
//  foodie
//
//  Created by Konrad Groschang on 28/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

extension EdgeInsets {
    
    static func makeInserts(vertical: CGFloat, horizontal: CGFloat) -> EdgeInsets { 
        EdgeInsets(
            top: vertical,
            leading: horizontal, //TODO: 
            bottom: vertical,
            trailing: horizontal
        )
    }

    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init()
        self.leading = horizontal
        self.top = vertical
        self.bottom = vertical
        self.trailing = horizontal
    }

    init(v: CGFloat, h: CGFloat) {
        self.init(vertical: v, horizontal: h)
    }
}


extension EdgeInsets {
    
    static let zero: EdgeInsets = .init(vertical: 0, horizontal: 0)
}
