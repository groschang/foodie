//
//  HTTPSession.swift
//  foodie
//
//  Created by Konrad Groschang on 04/09/2023.
//

import Foundation

protocol HTTPSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: HTTPSession { }
