//
//  LoadableObject.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

@MainActor
protocol LoadableObject: ObservableObject {
    var state: LoadingState { get }
    var isEmpty: Bool { get }
    
    func load() async
}
