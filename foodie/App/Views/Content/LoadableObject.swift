//
//  LoadableObject.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//

import Foundation

protocol LoadableObject: ObservableObject {
    var state: LoadingState { get }
    var isEmpty: Bool { get }
    
    func load() async
}
