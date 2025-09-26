//
//  HTTPSession.swift
//  foodie
//
//  Created by Konrad Groschang on 04/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

protocol HTTPSession: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}


extension URLSession: HTTPSession { }
