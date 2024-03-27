//
//  ListType.swift
//  foodie
//
//  Created by Konrad Groschang on 23/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

enum ListType: CaseIterable {

    case list
    case post
    case grid
    
}

extension ListType {

    var image: Image {
        var imageName: String

        switch self {
        case .list:
            imageName = "list.bullet"
        case .post:
            imageName = "rectangle.grid.1x2.fill"
        case .grid:
            imageName = "square.grid.2x2.fill"
        }

        return Image(systemName: imageName)
    }
}
