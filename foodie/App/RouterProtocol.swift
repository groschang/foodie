//
//  Router.swift
//  foodie
//
//  Created by Konrad Groschang on 25/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

protocol RouterProtocol: Hashable {
    associatedtype V: View
    @MainActor func makeView() async -> V
}
