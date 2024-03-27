//
//  MocksPreview.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct MocksPreview<MockView, ViewModelType>: View where MockView: View {

    let mocks: [any Mock]

    let type: ViewModelType.Type

    let mockView: (ViewModelType) -> MockView

    var body: some View {
        ForEach(mocks, id: \.mockType) { mock in
            mockView(mock as! ViewModelType)
                .nameMock(mock)
        }
    }
}
