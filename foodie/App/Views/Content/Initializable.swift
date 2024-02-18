//
//  Initializable.swift
//  foodie
//
//  Created by Konrad Groschang on 18/12/2023.
//

import Foundation

protocol Initializable {
    var initialized: Bool { get }
    func initialize() async
}
