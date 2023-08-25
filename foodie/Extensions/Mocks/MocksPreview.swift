//
//  MocksPreview.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import SwiftUI

struct MocksPreview<MockView, VMType>: View where MockView: View {

    let mocks: [any Mock]

    let viewModelType: VMType.Type

    let mockView: (VMType) -> MockView

    var body: some View {
        ForEach(mocks, id: \.mockType) { mock in
            mockView(mock as! VMType)
                .nameMock(mock)
        }
    }
}
