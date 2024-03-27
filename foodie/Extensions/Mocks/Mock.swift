//
//  Mock.swift
//  foodie
//
//  Created by Konrad Groschang on 09/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

protocol Mock {
    var mockType: MockType { get }
}

extension Mock {
    var mockType: String { mockType.rawValue } 
}

extension View {
    func nameMock(_ type: Mock) -> some View {
        previewDisplayName(type.mockType)
    }
}
