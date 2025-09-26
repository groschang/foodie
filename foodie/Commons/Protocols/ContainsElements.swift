//
//  ContainsElements.swift
//  foodie
//
//  Created by Konrad Groschang on 27/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

protocol HasElements {
    var isEmpty: Bool { get }
}


protocol HasNotElements {
    var isNotEmpty: Bool { get }
}


protocol ContainsElements: HasElements, HasNotElements { }


extension ContainsElements {
    var isNotEmpty: Bool { isEmpty == false }
}
